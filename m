Return-Path: <SRS0=fEc7=KY=gigaio.com=kchow@kernel.org>
Return-Path: <SRS0=fEc7=KY=gigaio.com=kchow@kernel.org>
Subject: Re: IOAT DMA w/IOMMU
To: Logan Gunthorpe <logang@deltatee.com>, "Jiang, Dave"
 <dave.jiang@intel.com>, Eric Pilmore <epilmore@gigaio.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
 <20180809184331.GB113140@bhelgaas-glaptop.roam.corp.google.com>
 <CAOQPn8uPYKai49WYPqZp2wNd5of=0hUvPOHEtqP56RZu-hcjuw@mail.gmail.com>
 <b54899a8-a144-e8e0-9880-1800c4657b95@deltatee.com>
 <95e53520-b05f-4be4-e694-463d717453a8@gigaio.com>
 <cdd9245f-eb23-9e10-1755-8f396a2cd255@deltatee.com>
 <b278c1e5-6f08-c879-a27d-7fc172645fd5@gigaio.com>
 <f04fae39-645e-3c6e-07c0-b194260bf5de@deltatee.com>
 <3f503940-db6a-ec75-ed15-1db99d5d48ef@gigaio.com>
 <112A412BB11A1242B37129D931BCE5348382CFB2@fmsmsx117.amr.corp.intel.com>
 <b8af340c-d40b-cb8c-987f-b394f1d6ec3e@gigaio.com>
 <adf51c74-36fa-b61d-8497-27bd75178ba4@deltatee.com>
From: Kit Chow <kchow@gigaio.com>
Message-ID: <aa9c3f41-efc9-8c68-a517-2736c8986621@gigaio.com>
Date: Thu, 9 Aug 2018 16:00:00 -0700
MIME-Version: 1.0
In-Reply-To: <adf51c74-36fa-b61d-8497-27bd75178ba4@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>



On 08/09/2018 03:50 PM, Logan Gunthorpe wrote:
>
> On 09/08/18 04:48 PM, Kit Chow wrote:
>> Based on Logan's comments, I am very hopeful that the dma_map_resource
>> will make things work on the older platforms...
> Well, I *think* dma_map_single() would still work. So I'm not that
> confident that's the root of your problem. I'd still like to see the
> actual code snippet you are using.
>
> Logan
Here's the code snippet - (ntbdebug & 4) path does dma_map_resource of 
the pci bar address.

It was:
                 unmap->addr[1] = dma_map_single(device->dev, (void 
*)dest, len,
                     DMA_TO_DEVICE);

Kit
---


static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
                                struct ntb_queue_entry *entry)
{
         struct dma_async_tx_descriptor *txd;
         struct dma_chan *chan = qp->tx_dma_chan;
         struct dma_device *device;
         size_t len = entry->len;
         void *buf = entry->buf;
         size_t dest_off, buff_off;
         struct dmaengine_unmap_data *unmap;
         dma_addr_t dest;
         dma_cookie_t cookie;
         int     unmapcnt;

         device = chan->device;

         dest = qp->tx_mw_phys + qp->tx_max_frame * entry->tx_index;

         buff_off = (size_t)buf & ~PAGE_MASK;
         dest_off = (size_t)dest & ~PAGE_MASK;

         if (!is_dma_copy_aligned(device, buff_off, dest_off, len))
                 goto err;


         if (ntbdebug & 0x4) {
                 unmapcnt = 2;
         } else {
                 unmapcnt = 1;
         }

         unmap = dmaengine_get_unmap_data(device->dev, unmapcnt, 
GFP_NOWAIT);
         if (!unmap)
                 goto err;

         unmap->len = len;
         unmap->addr[0] = dma_map_page(device->dev, virt_to_page(buf),
                                       buff_off, len, DMA_TO_DEVICE);
         if (dma_mapping_error(device->dev, unmap->addr[0]))
                 goto err_get_unmap;

         if (ntbdebug & 0x4) {
                 unmap->addr[1] = dma_map_resource(device->dev,
                     (phys_addr_t)dest, len, DMA_TO_DEVICE, 0);
                 if (dma_mapping_error(device->dev, unmap->addr[1]))
                         goto err_get_unmap;
                 unmap->to_cnt = 2;
         } else {
                 unmap->addr[1] = dest;
                 unmap->to_cnt = 1;
         }

         txd = device->device_prep_dma_memcpy(chan, unmap->addr[1],
             unmap->addr[0], len, DMA_PREP_INTERRUPT);

         if (!txd)
                 goto err_get_unmap;

         txd->callback_result = ntb_tx_copy_callback;
         txd->callback_param = entry;
         dma_set_unmap(txd, unmap);

         cookie = dmaengine_submit(txd);
         if (dma_submit_error(cookie))
                 goto err_set_unmap;

         dmaengine_unmap_put(unmap);

         dma_async_issue_pending(chan);

         return 0;

err_set_unmap:
         dma_descriptor_unmap(txd);
         txd->desc_free(txd);
err_get_unmap:
         dmaengine_unmap_put(unmap);
err:
         return -ENXIO;
}

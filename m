Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 20 Oct 2017 10:02:46 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
cc: Christoph Hellwig <hch@lst.de>, Bhumika Goyal <bhumirks@gmail.com>,
        julia.lawall@lip6.fr, rjw@rjwysocki.net, lenb@kernel.org,
        alexander.shishkin@linux.intel.com, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        dledford@redhat.com, sean.hefty@intel.com,
        hal.rosenstock@gmail.com, sagi@grimberg.me, kishon@ti.com,
        bhelgaas@google.com, nab@linux-iscsi.org, balbi@kernel.org,
        gregkh@linuxfoundation.org, jlbec@evilplan.org,
        ccaulfie@redhat.com, teigland@redhat.com, mfasheh@versity.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-usb@vger.kernel.org,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 02/15] usb: gadget: make config_item_type structures
 const
In-Reply-To: <6348630.r2z9ev4yl2@avalon>
Message-ID: <alpine.DEB.2.20.1710200857030.2090@hadrien>
References: <1508167134-6243-1-git-send-email-bhumirks@gmail.com> <1985905.z83BJQzMUS@avalon> <20171019140657.GA22233@lst.de> <6348630.r2z9ev4yl2@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Thu, 19 Oct 2017, Laurent Pinchart wrote:

> Hi Christoph,
>
> On Thursday, 19 October 2017 17:06:57 EEST Christoph Hellwig wrote:
> > > Now we have 9 const instances of the config_item_type structure that are
> > > identical, with only the .ct_owner field set. Should they be all merged
> > > into a single structure ?
> >
> > I think that's a good idea.
> >
> > But I'm about to slurp up this whole series into my tree, how about making
> > that an incremental patch?
>
> I'm fine with that.
>
> Bhumika, would you like to submit an incremental patch, or should I do it ?

For various types, there seem to be a few hundred of these, eg:

static const struct hda_pcm_stream alc269_44k_pcm_analog_playback = {
        .rates = SNDRV_PCM_RATE_44100, /* fixed rate */
};

static const struct hda_pcm_stream alc269_44k_pcm_analog_capture = {
        .rates = SNDRV_PCM_RATE_44100, /* fixed rate */
};

Would it be desirable to remove them?  I guess one would have to check
that there are not any pointer equality checks on these values.  Would it
be useful to put a #define to keep the orignal names?

julia

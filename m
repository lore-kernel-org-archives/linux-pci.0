Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50028 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754914AbcEBUnN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 2 May 2016 16:43:13 -0400
Date: Mon, 2 May 2016 15:43:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: linux-pci@vger.kernel.org, devel@linuxdriverproject.org,
	linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jake Oshins <jakeo@microsoft.com>
Subject: Re: [PATCH] PCI: hv: report resources release after stopping the bus
Message-ID: <20160502204303.GL24851@localhost>
References: <1461922750-26053-1-git-send-email-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461922750-26053-1-git-send-email-vkuznets@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 29, 2016 at 11:39:10AM +0200, Vitaly Kuznetsov wrote:
> Kernel hang is observed when pci-hyperv module is release with device
> drivers still attached. E.g. when I do 'rmmod pci_hyperv' with BCM5720
> device pass-through-ed (tg3 module) I see the following:
> 
>  NMI watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [rmmod:2104]
>  ...
>  Call Trace:
>   [<ffffffffa0641487>] tg3_read_mem+0x87/0x100 [tg3]
>   [<ffffffffa063f000>] ? 0xffffffffa063f000
>   [<ffffffffa0644375>] tg3_poll_fw+0x85/0x150 [tg3]
>   [<ffffffffa0649877>] tg3_chip_reset+0x357/0x8c0 [tg3]
>   [<ffffffffa064ca8b>] tg3_halt+0x3b/0x190 [tg3]
>   [<ffffffffa0657611>] tg3_stop+0x171/0x230 [tg3]
>   ...
>   [<ffffffffa064c550>] tg3_remove_one+0x90/0x140 [tg3]
>   [<ffffffff813bee59>] pci_device_remove+0x39/0xc0
>   [<ffffffff814a3201>] __device_release_driver+0xa1/0x160
>   [<ffffffff814a32e3>] device_release_driver+0x23/0x30
>   [<ffffffff813b794a>] pci_stop_bus_device+0x8a/0xa0
>   [<ffffffff813b7ab6>] pci_stop_root_bus+0x36/0x60
>   [<ffffffffa02c3f38>] hv_pci_remove+0x238/0x260 [pci_hyperv]
> 
> The problem seems to be that we report local resources release before
> stopping the bus and removing devices from it and device drivers may
> try to perform some operations with these resources on shutdown. Move
> resources release report after we do pci_stop_root_bus().
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Applied with Jake's ack to pci/host-hv for v4.7, thanks, Vitaly!

> ---
>  drivers/pci/host/pci-hyperv.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index f2559b6..c17e792 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -2268,11 +2268,6 @@ static int hv_pci_remove(struct hv_device *hdev)
>  
>  	hbus = hv_get_drvdata(hdev);
>  
> -	ret = hv_send_resources_released(hdev);
> -	if (ret)
> -		dev_err(&hdev->device,
> -			"Couldn't send resources released packet(s)\n");
> -
>  	memset(&pkt.teardown_packet, 0, sizeof(pkt.teardown_packet));
>  	init_completion(&comp_pkt.host_event);
>  	pkt.teardown_packet.completion_func = hv_pci_generic_compl;
> @@ -2295,6 +2290,11 @@ static int hv_pci_remove(struct hv_device *hdev)
>  		pci_unlock_rescan_remove();
>  	}
>  
> +	ret = hv_send_resources_released(hdev);
> +	if (ret)
> +		dev_err(&hdev->device,
> +			"Couldn't send resources released packet(s)\n");
> +
>  	vmbus_close(hdev->channel);
>  
>  	/* Delete any children which might still exist. */
> -- 
> 2.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

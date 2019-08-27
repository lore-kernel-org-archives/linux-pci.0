Return-Path: <SRS0=srx4=WX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B1DC3A5A3
	for <linux-pci@archiver.kernel.org>; Tue, 27 Aug 2019 22:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7B8217F5
	for <linux-pci@archiver.kernel.org>; Tue, 27 Aug 2019 22:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566945088;
	bh=z3lcNGmdvmqEXqVEX9g8KC0XV/I/hJtGSWKjLohh+3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rnVQ3n3YgXDRNDoqy1nXO8Os1FeIxoepuE4MTEdVr9+YVIvFc/djpZM7Qitwt/KBV
	 /fhB7O5z7yaCsg+JcNcbXdBf6G9W363cyD5vQlC9t3ItykbnjQjbraA6vykFvPjefG
	 Hf5zrBsiDE2v7VyargkB+eysZWsMKOQSE6v1jQx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbfH0Wb2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Aug 2019 18:31:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfH0Wb2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 18:31:28 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C760F20856;
        Tue, 27 Aug 2019 22:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566945087;
        bh=z3lcNGmdvmqEXqVEX9g8KC0XV/I/hJtGSWKjLohh+3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Migu+if62iFs5FV4qKaJ8LZCNRwNok5KflTlEHuwAOZ9iaxShqp/IWMO+EImucQVc
         HD2pxOhjBOWs6s1j223Xn/n0+4yOH4Bg3uGkzkILe9q+GbkxbFe6WtEy54XmNqcZSV
         mFh7XfmdHOserrq/VomMnyq6vQFKnxrs0/zG1cPs=
Date:   Tue, 27 Aug 2019 17:31:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     tiwai@suse.com, linux-pci@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ALSA: hda: Allow HDA to be runtime suspended when
 dGPU is not bound
Message-ID: <20190827223125.GB9987@google.com>
References: <20190827134756.10807-1-kai.heng.feng@canonical.com>
 <20190827134756.10807-2-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827134756.10807-2-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 27, 2019 at 09:47:56PM +0800, Kai-Heng Feng wrote:
> It's a common practice to let dGPU unbound and use PCI port PM to
> disable its power through _PR3. When the dGPU comes with an HDA
> function, the HDA won't be suspended if the dGPU is unbound, so the dGPU
> power can't be disabled.

Just a terminology question:

I thought "using PCI port PM" meant using the PCI Power Management
Capability in config space to directly change the device's power
state, e.g., in pci_raw_set_power_state().

And I thought using _PS3, _PR3, etc would be part of "platform power
management"?

And AFAICT, _PR3 merely returns a list of power resources; it doesn't
disable power itself.

> Commit 37a3a98ef601 ("ALSA: hda - Enable runtime PM only for
> discrete GPU") only allows HDA to be runtime-suspended once GPU is
> bound, to keep APU's HDA working.
> 
> However, HDA on dGPU isn't that useful if dGPU is unbound. So let relax
> the runtime suspend requirement for dGPU's HDA function, to save lots of
> power.
> 
> BugLink: https://bugs.launchpad.net/bugs/1840835
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  sound/pci/hda/hda_intel.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 99fc0917339b..d4ee070e1a29 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -1285,7 +1285,8 @@ static void init_vga_switcheroo(struct azx *chip)
>  		dev_info(chip->card->dev,
>  			 "Handle vga_switcheroo audio client\n");
>  		hda->use_vga_switcheroo = 1;
> -		hda->need_eld_notify_link = 1; /* cleared in gpu_bound op */
> +		/* cleared in gpu_bound op */
> +		hda->need_eld_notify_link = !pci_pr3_present(p);
>  		chip->driver_caps |= AZX_DCAPS_PM_RUNTIME;
>  		pci_dev_put(p);
>  	}
> -- 
> 2.17.1
> 

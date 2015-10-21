Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36319 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755673AbbJUSvO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Oct 2015 14:51:14 -0400
Received: by igdg1 with SMTP id g1so93372734igd.1
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2015 11:51:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20151021183741.28724.71281.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20151021183741.28724.71281.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Date: Wed, 21 Oct 2015 16:51:13 -0200
Message-ID: <CAOMZO5Au6KvTu1MkE8sh57YhOtY0_g7BmSiUkRxx-DwFt6zEFA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] PCI: designware: LTSSM #define cleanup
From: Fabio Estevam <festevam@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pratyush Anand Thakur <pratyush.anand@gmail.com>,
	m-karicheri2 <m-karicheri2@ti.com>,
	Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Wed, Oct 21, 2015 at 4:42 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> This is a revision of Fabio's series:
> http://lkml.kernel.org/r/1444664808-16445-1-git-send-email-festevam@gmail.com
>
> Lucas, you reviewed the v3 patches, but I fiddled enough with this that I
> didn't want to blindly carry your review forward.  I don't *think* I
> changed anything substantive, but I might have missed something.
>
> Changes since Fabio's v3:
>   - Split removal of spear unused #defines to separate patch
>   - Combine LTSSM_STATE_MASK definition and use changes in one patch
>   - Combine LTSSM_STATE_RCVRY_LOCK definition and use in one patch
>   - Use common LTSSM_STATE_L0 definition

Thanks for reworking the series. It looks better now, thanks.

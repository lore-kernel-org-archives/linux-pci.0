Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:58766 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbbAIBZY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jan 2015 20:25:24 -0500
Date: Thu, 8 Jan 2015 20:25:19 -0500 (EST)
From: Alex Williamson <alex.williamson@redhat.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Venkat Duvvuru <VenkatKumar.Duvvuru@Emulex.Com>,
	Ajit Kumar Khaparde <Ajit.Khaparde@Emulex.Com>,
	bhelgaas@google.com, linux-pci@vger.kernel.org
Message-ID: <1257448143.6977594.1420766719306.JavaMail.zimbra@redhat.com>
In-Reply-To: <20150109003320.GA24054@shangw>
References: <1420424274-3194-1-git-send-email-gwshan@linux.vnet.ibm.com> <a227414f-6f4b-4656-b65b-ef8d6e68f135@CMEXHTCAS1.ad.emulex.com> <20150109003320.GA24054@shangw>
Subject: Re: [PATCH] PCI: Mark broken INTx masking for BENET devices
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



----- Original Message -----
> On Thu, Jan 08, 2015 at 11:33:46AM +0000, Venkat Duvvuru wrote:
> >Hi Gavin,
> >We tried to reproduce this in our lab but our observation is that we don't
> >see "interrupt storm" in our system.
> >Could you please give us the details of the repro scenario?
> >
> >A few more details will help us understand the problem better as well.
> >1. be2net driver version
> >2. be2net firmware version
> >3. lspci -vvv output of the card (lspci -d 19a2: -vvv)
> >4. Is SR-IOV enabled in your card?
> >
> 
> Venkat, On IBM's Power7 box, I passed through following adpater to guest with
> following
...
> 
> Steps to recreate the issue
> ===========================
> 
> 1. Configure the NIC and ping it from external.
> 2. Inject EEH error by running following command in host side. After about
>    20 seconds, I got following message from host side. With the patch applied
>    to host kernel, I didn't see the warning messages:

This seems really dubious and I don't see any justification at all for declaring DisINTx broken for all devices for the vendor.  Typically to call DisINTx broken for a given device, you can just boot the guest with pci=nomsi to force INTx to be used.  If that works, then DisINTx masking works.  If you require EEH injection to to trigger this, then the problem is more likely some containment issue during EEH recovery.  Thanks,

Alex

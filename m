Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from co1ehsobe004.messaging.microsoft.com ([216.32.180.187]:36424
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755833Ab3LITf4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 9 Dec 2013 14:35:56 -0500
From: Rajat Jain <rajatjain@juniper.net>
To: Yinghai Lu <yinghai@kernel.org>
CC: Ethan Zhao <ethan.kernel@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Guenter Roeck <groeck@juniper.net>
Subject: RE: [PATCH] PCI, pciehp: Turn on link a while to workaround
 presense detection
Date: Mon, 9 Dec 2013 19:35:49 +0000
Message-ID: <8833f61075af4c97895aadc42c3f7335@DM2PR05MB671.namprd05.prod.outlook.com>
References: <1386361357-7767-1-git-send-email-yinghai@kernel.org>
	<CAErSpo5BnfmRJjXBqM7pWrMgvUt60hfC9oRbGy7=h6+Gftepqg@mail.gmail.com>
	<aaaa948b964642859fa142779846211f@DM2PR05MB671.namprd05.prod.outlook.com>
	<CABawtvPMSGc+7HqqtE9NXxCo11Vp-Yu+feF6UqS18k+jwPxoVw@mail.gmail.com>
	<c2a37fdd0e654fa3adccb0bcc38adb09@DM2PR05MB671.namprd05.prod.outlook.com>
 <CAE9FiQU7gM3gQkhWMXCTrJUqL137TW2TBL_gW=N2s3cbHr+5EA@mail.gmail.com>
In-Reply-To: <CAE9FiQU7gM3gQkhWMXCTrJUqL137TW2TBL_gW=N2s3cbHr+5EA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Yinghai,

> -----Original Message-----
> From: yhlu.kernel@gmail.com [mailto:yhlu.kernel@gmail.com] On Behalf Of
> Yinghai Lu
> Sent: Monday, December 09, 2013 11:28 AM
> To: Rajat Jain
> Cc: Ethan Zhao; Bjorn Helgaas; linux-pci@vger.kernel.org; Kenji
> Kaneshige; stable@vger.kernel.org; Guenter Roeck
> Subject: Re: [PATCH] PCI, pciehp: Turn on link a while to workaround
> presense detection
> 
> On Mon, Dec 9, 2013 at 10:46 AM, Rajat Jain <rajatjain@juniper.net>
> wrote:
> >
> > This is for the systems that do not implement elements like attention
> button:
> 
> then your pcie slot should add Surprise Removal/Insert support in your
> HW?
> 

Actually there are situations where the presence detect signal does not make much sense, because the card is not really plugged out physically. For e.g. how do we deal with PCIe end points that may be on the board itself, but say come out of reset after the bootup? Or go down during a firmware upgrade and again come back up after the upgrade? 


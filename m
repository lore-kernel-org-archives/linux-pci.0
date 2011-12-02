Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:43618 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753498Ab1LBXWn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Dec 2011 18:22:43 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id DD48C20F27
	for <linux-pci@vger.kernel.org>; Fri,  2 Dec 2011 18:22:42 -0500 (EST)
Date: Fri, 2 Dec 2011 15:21:25 -0800
From: Greg KH <greg@kroah.com>
To: Yinghai Lu <yinghai.lu@oracle.com>
Cc: Greg KH <gregkh@suse.de>, stable@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: pciehp for stable
Message-ID: <20111202232125.GE6016@kroah.com>
References: <4EB94A51.6070809@oracle.com>
 <4EB9A50D.1040302@oracle.com>
 <4EBB7F9B.8050703@jp.fujitsu.com>
 <4EBB8058.6090500@jp.fujitsu.com>
 <4EBC21C0.5070806@oracle.com>
 <20111111093212.3cceee91@jbarnes-desktop>
 <4EBD5C6C.9010606@oracle.com>
 <20111111174053.GA27014@suse.de>
 <4ECDA602.9060103@oracle.com>
 <20111127032544.GB2369@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111127032544.GB2369@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Nov 26, 2011 at 07:25:44PM -0800, Greg KH wrote:
> On Wed, Nov 23, 2011 at 06:03:46PM -0800, Yinghai Lu wrote:
> > On 11/11/2011 09:40 AM, Greg KH wrote:
> > 
> > >> Thanks, We may need to put them into stable too.
> > > 
> > > Then send stable@vger.kernel.org the git commit ids once they show up in
> > > Linus's tree.
> > > 
> > 
> > 
> > >From 0027cb3e1947d0f453fece40ed16764fb362bac6 Mon Sep 17 00:00:00 2001
> > From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
> > Date: Thu, 10 Nov 2011 16:40:37 +0900
> > Subject: [PATCH] PCI: pciehp: wait 1000 ms before Link Training check
> > 
> > 
> > >From b3c004542229099e18198061c737e13eafc8d4d6 Mon Sep 17 00:00:00 2001
> > From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
> > Date: Thu, 10 Nov 2011 16:42:16 +0900
> > Subject: [PATCH] PCI: pciehp: wait 100 ms after Link Training check
> 
> Are you sure these patches are correct?  Linus complained about them,
> and I will to :)
> 
> Please get Jesse to ack them and I'll apply them.

As I have gotten no reply in the week since I sent this, I'm dropping
this request from my queue, sorry.

greg k-h

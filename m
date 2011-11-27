Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35501 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751275Ab1K0KHh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 27 Nov 2011 05:07:37 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 0355821A28
	for <linux-pci@vger.kernel.org>; Sun, 27 Nov 2011 05:07:37 -0500 (EST)
Date: Sat, 26 Nov 2011 19:25:44 -0800
From: Greg KH <greg@kroah.com>
To: Yinghai Lu <yinghai.lu@oracle.com>
Cc: Greg KH <gregkh@suse.de>, stable@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: pciehp for stable
Message-ID: <20111127032544.GB2369@kroah.com>
References: <4EB8F434.6090003@jp.fujitsu.com>
 <4EB94A51.6070809@oracle.com>
 <4EB9A50D.1040302@oracle.com>
 <4EBB7F9B.8050703@jp.fujitsu.com>
 <4EBB8058.6090500@jp.fujitsu.com>
 <4EBC21C0.5070806@oracle.com>
 <20111111093212.3cceee91@jbarnes-desktop>
 <4EBD5C6C.9010606@oracle.com>
 <20111111174053.GA27014@suse.de>
 <4ECDA602.9060103@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4ECDA602.9060103@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 23, 2011 at 06:03:46PM -0800, Yinghai Lu wrote:
> On 11/11/2011 09:40 AM, Greg KH wrote:
> 
> >> Thanks, We may need to put them into stable too.
> > 
> > Then send stable@vger.kernel.org the git commit ids once they show up in
> > Linus's tree.
> > 
> 
> 
> >From 0027cb3e1947d0f453fece40ed16764fb362bac6 Mon Sep 17 00:00:00 2001
> From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
> Date: Thu, 10 Nov 2011 16:40:37 +0900
> Subject: [PATCH] PCI: pciehp: wait 1000 ms before Link Training check
> 
> 
> >From b3c004542229099e18198061c737e13eafc8d4d6 Mon Sep 17 00:00:00 2001
> From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
> Date: Thu, 10 Nov 2011 16:42:16 +0900
> Subject: [PATCH] PCI: pciehp: wait 100 ms after Link Training check

Are you sure these patches are correct?  Linus complained about them,
and I will to :)

Please get Jesse to ack them and I'll apply them.

thanks,

greg k-h

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137]:58036 "EHLO e7.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757733Ab2FECzF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 4 Jun 2012 22:55:05 -0400
Received: from /spool/local
	by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <linuxram@us.ibm.com>;
	Mon, 4 Jun 2012 22:55:02 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 7EA5538C8026
	for <linux-pci@vger.kernel.org>; Mon,  4 Jun 2012 22:54:27 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q552sRmA094140
	for <linux-pci@vger.kernel.org>; Mon, 4 Jun 2012 22:54:27 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q558PI2F020680
	for <linux-pci@vger.kernel.org>; Tue, 5 Jun 2012 04:25:19 -0400
Date: Tue, 5 Jun 2012 10:54:22 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: Rob Allen <ra-kernel@hotmail.co.uk>
Cc: Ram Pai <linuxram@us.ibm.com>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Clemens Ladisch <clemens@ladisch.de>,
	Yinghai Lu <yinghai@kernel.org>,
	linux1394-devel@lists.sourceforge.net, linux-pci@vger.kernel.org
Subject: Re: [Bug 43244] New: firewire_ohci prevents boot
Message-ID: <20120605025422.GB6637@ram-ThinkPad-T61>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20120513221357.7574ae79@stein>
 <4FB0A6F6.9050504@ladisch.de>
 <CAE9FiQXA4C8hACXChokL4CZVBDhdh17Qs7tngn5q-pS0U5=bPQ@mail.gmail.com>
 <BLU0-SMTP12B809D527F768CCC42B18B7180@phx.gbl>
 <4FB3B159.2090401@ladisch.de>
 <BLU0-SMTP47479D78AA811CB0B224ADFB71D0@phx.gbl>
 <4FBAA3A5.4070200@ladisch.de>
 <20120524202610.5c561d99@stein>
 <4FBE8146.1030803@hotmail.co.uk>
 <BLU0-SMTP435F81F04D60963F0755BA9B70F0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BLU0-SMTP435F81F04D60963F0755BA9B70F0@phx.gbl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 04, 2012 at 12:00:10PM +0100, Rob Allen wrote:
> Ram Pai,
> 
> I've found the change that introduced the failure I'm seeing, and it
> seems you are the author. Please can you offer some help?
> 
> commit 0a2daa1cf35004f5adbf4138555cc5669abf3a3e
> Author: Ram Pai <linuxram@us.ibm.com>
> Date:   Mon Jul 25 13:08:41 2011 -0700
> 
>     PCI: make cardbus-bridge resources optional
> 
>     Allocate resources to cardbus bridge only after all other genuine
>     resources requests are satisfied. Dont retry if resource allocation
>     for cardbus-bridges fail.
> 
>     Signed-off-by: Ram Pai <linuxram@us.ibm.com>
>     Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>

Yes looking into it. The resource assignment for one of the BARs of the
firewire ohci device at 0a:09.4 has got reassigned a valid address
AFAICT.  I think that device does not like the OS to reassign any resources.

We need to determine whether the ohci device behaves abnormally if it gets
assigned a address other than what is assigned by the BIOS. 

To do that; as Yinghai suggested, lets see the contents of the
register with and without the patch.

output of the following command on a working kernel and a non-working
kernel will shed some light.

lspci -vvxxx -s 0a:09.4

also boot messages on a working kernel will also be helpful.
RP


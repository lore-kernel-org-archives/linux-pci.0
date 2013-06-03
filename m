Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60214 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755329Ab3FCS6y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 3 Jun 2013 14:58:54 -0400
Message-ID: <51ACE76B.1000307@redhat.com>
Date: Mon, 03 Jun 2013 14:58:51 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Bryce Lelbach <blelbach@cct.lsu.edu>
CC: linux-pci@vger.kernel.org
Subject: Re: Patch: Increase maximum bus memory window size (for Xeon Phi)
References: <20130524165947.GA2487@pyxis.br.cox.net>
In-Reply-To: <20130524165947.GA2487@pyxis.br.cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/24/2013 12:59 PM, Bryce Lelbach wrote:
> The attached patch affects pbus_size_mem() in drivers/pci/setup-bus.c. The patch
> increases the maximum memory window size for a PCI bus from 2 Gb to 2^63 Gb.
>
> This change is necessary to support Intel Xeon Phi co-processors. These co-processors
> are PCIe devices used for high-performance computing applications. The device requires
> an 8Gb memory window to function (the co-processor has 8Gb of onboard memory).
>
> This patch is a modified version of a patch from Intel's MPSS framework
> (specifically, from the "KNC_gold_update_1-2.1.4982-15-rhel-6.3" package), which
> will apply to a 3.7.8 kernel (I am about to try it on a 3.8 kernel). To the best
> of my knowledge, newer RHEL kernels are shipped with this patch.
>
This patch is not in (the latest) RHEL6(.4) or the internal staging tree for the next
RHEL6(.5) release.



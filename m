Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:51348 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793Ab3GHEhG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jul 2013 00:37:06 -0400
Date: Mon, 8 Jul 2013 06:37:03 +0200
From: Andi Kleen <andi@firstfloor.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Alexander Duyck <alexander.h.duyck@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andi Kleen <andi@firstfloor.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] pci: Avoid unnecessary calls to work_on_cpu
Message-ID: <20130708043703.GT6123@two.firstfloor.org>
References: <20130624195942.40795.27292.stgit@ahduyck-cp1.jf.intel.com>
 <CAErSpo70VKFxJqyZJKSp=CZ2x131Kz_+0vah3juTEuEx5RLX8A@mail.gmail.com>
 <87wqp1esff.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87wqp1esff.fsf@rustcorp.com.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> > But Rusty added this (in 873392ca51), and he knows way more about this
> > stuff than I do.
> 
> Actually, I just stopped the code from playing cpumask games, which is
> what it used to do.

You're right the numa_node_id() check ptimization is not 100% safe on preempt 
kernels and should be probably removed. Also I agree it would probably
make sense to move it up to the generic device layer (although I'm not
sure that other bus types really care that much about NUMA locality)

None of it seems to be a fatal problem though, so it boils down to
"if someone cares enough to write a patch"

-Andi

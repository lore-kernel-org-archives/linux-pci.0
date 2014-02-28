Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fw-tnat.austin.arm.com ([217.140.110.23]:16837 "EHLO
	collaborate-mta1.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751677AbaB1P1X (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Feb 2014 10:27:23 -0500
Date: Fri, 28 Feb 2014 15:27:10 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Will Deacon <Will.Deacon@arm.com>,
	linaro-kernel <linaro-kernel@lists.linaro.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/3] arm64: Extend the PCI I/O space to 16MB
Message-ID: <20140228152710.GC13970@arm.com>
References: <1393506599-11561-1-git-send-email-Liviu.Dudau@arm.com>
 <1393506599-11561-3-git-send-email-Liviu.Dudau@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393506599-11561-3-git-send-email-Liviu.Dudau@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 27, 2014 at 01:09:58PM +0000, Liviu Dudau wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> The patch moves the PCI I/O space (currently at 64K) before the
> earlyprintk mapping and extends it to 16MB.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

I'll push this into mainline for 3.15, no need to carry it.

-- 
Catalin

Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V2] acpi, pci, irq: account for early penalty assignment
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1455801582-21595-1-git-send-email-okaya@codeaurora.org>
 <20160229192420.GC3653@localhost> <56D4A53A.1070708@codeaurora.org>
 <20160229223453.GA12162@localhost> <56D5E43E.7050406@codeaurora.org>
 <20160301194340.GA19783@localhost> <56D7317F.7090500@codeaurora.org>
 <56D7ABFB.3070302@codeaurora.org> <56D84EA9.3080900@codeaurora.org>
 <20160303151048.GA3290@localhost>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, linux-pci@vger.kernel.org,
	ravikanth.nalla@hpe.com, lenb@kernel.org, harish.k@hpe.com,
	ashwin.reghunandanan@hpe.com, bhelgaas@google.com,
	rjw@rjwysocki.net, linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <56D8546B.5040908@codeaurora.org>
Date: Thu, 3 Mar 2016 10:12:43 -0500
MIME-Version: 1.0
In-Reply-To: <20160303151048.GA3290@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 3/3/2016 10:10 AM, Bjorn Helgaas wrote:
> That was my idea, but your minimal patch from last night looks awfully
> attractive, and maybe it's not worth moving it to arch/x86.  I do think we
> could simplify the code significantly by getting rid of the kzalloc and
> acpi_irq_penalty_list from acpi_irq_set_penalty().  How about pushing on
> that a little bit first, and see what it looks like then?

OK. Let me go that direction.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

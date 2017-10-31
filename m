Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751691AbdJaImp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Oct 2017 04:42:45 -0400
Subject: Cleaning up non-standard PCIe ECAM on Arm servers
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-pci@vger.kernel.org
References: <20171006163919.14898-1-ard.biesheuvel@linaro.org>
 <20171006163919.14898-2-ard.biesheuvel@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Will Deacon <will.deacon@arm.com>
From: Jon Masters <jcm@redhat.com>
Message-ID: <2621d6ac-3b5c-7191-02eb-2f4980890d03@redhat.com>
Date: Tue, 31 Oct 2017 04:42:38 -0400
MIME-Version: 1.0
In-Reply-To: <20171006163919.14898-2-ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset=gbk
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/06/2017 12:39 PM, Ard Biesheuvel wrote:
> Some implementations of the Synopsys DesignWare PCIe controller implement
> a so-called ECAM shift mode, which allows a static memory window to be
> configured that covers the configuration space of the entire bus range.

Side note that we gave a presentation at Arm TechCon last week with
Cadence about a new program they're offering to perform verification of
PCIe pre-silicon using Palladium with speedbridges and running full
server Operating Systems booting using UEFI/ACPI under emulation. We've
been able to boot RHEL for Arm on these Palladium based platforms for a
while and are collaborating to turn this into a comprehensive program.

Once that was Cadence effort was announced, I pinged Synopsys to ask
them to go clean things up properly for their IP as well. Ultimately
we'll get to all the major IP vendors, and a number of PCIe specific
vendors have already had prodding from me directly over the years. So if
folks see this thread, are in the business of selling PCIe RC IP for Arm
server designs, and we haven't spoken yet, you should ping me. And you
should also talk with smart folks like Ard on how to do this right.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop

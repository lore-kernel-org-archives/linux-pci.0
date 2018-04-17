Return-Path: <linux-acpi-owner@vger.kernel.org>
To: Linux PCI <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
Subject: RFC on MCFG Table Support
Message-ID: <bd3f4d3a-f641-7385-4ce2-d62a28bc9cd3@codeaurora.org>
Date: Tue, 17 Apr 2018 12:18:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

QDT is working with PCI-SIG to revisit some of the spec language ambiguity
on the definition of PCI Segment Group in PCI FW Specification. 

PCI spec is currently requiring a single entry per segment in the MCFG table
with a contiguous 256MB range. 

Based on our research, this rule is being violated in the industry for existing
platforms due to the different ways spec is interpreted.

We are trying to remove this restriction in the spec and have multiple entries
per segment as long as <segment, bus start number, bus end number> tuple is
unique. 

AFAIS, generic ACPI Linux driver already supports this via pci_mcfg_lookup(). 

I also did a prototype and observed that I can enumerate two root ports without
any issues. 

I wanted to seek opinion on whether this is a valid assumption and if I'm missing
something.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

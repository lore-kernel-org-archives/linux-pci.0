Return-Path: <SRS0=UWQ+=GM=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=UWQ+=GM=codeaurora.org=okaya@kernel.org>
Subject: Re: PCIe resets/restore and lack of CRS wait
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Michael Neuling <michael.neuling@au1.ibm.com>,
 linux-pci-owner@vger.kernel.org
References: <1521691380.16434.287.camel@kernel.crashing.org>
 <f6af9b6e424c469f433735a106b8ee69@codeaurora.org>
 <1521695531.16434.294.camel@kernel.crashing.org>
 <1521699853.16434.301.camel@kernel.crashing.org>
 <4d1c04efa51db50dd5095ae258c3c52b@codeaurora.org>
 <1521726371.16434.307.camel@kernel.crashing.org>
 <172f0ea9-7eba-1505-bb79-1ee31cc4d692@codeaurora.org>
 <20180322141402.GA242245@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <6aec45f1-74d9-d36f-7169-0c91733985e3@codeaurora.org>
Date: Thu, 22 Mar 2018 12:54:01 -0500
MIME-Version: 1.0
In-Reply-To: <20180322141402.GA242245@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Ben,

On 3/22/2018 9:14 AM, Bjorn Helgaas wrote:
> CRS SV is optional, so the code has to work when it's absent.  But we
> can tell whether it's supported, so if we need to, we can do something
> different when it's absent.

Let us know if you want to work on this or not. Otherwise, I'll add
to the list of things I'm doing.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

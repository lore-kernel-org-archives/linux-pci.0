Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2 06/10] PCI: Introduce
 devm_of_pci_get_host_bridge_resources()
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
 <215a020abbafc599bda18463db6818fcb0d198c7.1525067324.git.jan.kiszka@siemens.com>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <38bb255b-925a-e373-1107-259734a15b9b@mentor.com>
Date: Thu, 3 May 2018 10:15:20 +0300
MIME-Version: 1.0
In-Reply-To: <215a020abbafc599bda18463db6818fcb0d198c7.1525067324.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/30/2018 08:48 AM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> of_pci_get_host_bridge_resources() allocates the resource structures it
> fills dynamically, but none of its callers care to release them so far.
> Rather than requiring everyone to do this explicitly, introduce a
> managed version of that service. This differs API-wise only in taking a
> reference to the associated device, rather than to the device tree node.
> 
> As of_pci_get_host_bridge_resources() is an exported interface, we
> cannot simply drop it at this point. After converting all in-tree users
> to the new API, we will phase out the unmanaged one.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Tested-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

--
With best wishes,
Vladimir

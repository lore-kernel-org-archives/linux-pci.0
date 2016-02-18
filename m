Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Qipeng Zha <qipeng.zha@intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, mika.westerberg@intel.com,
	Qi Zheng <qi.zheng@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] PCI/PM: Revert "PCI/PM: Drop unused runtime PM support code for PCIe ports"
Date: Thu, 18 Feb 2016 02:54:18 +0100
Message-ID: <2291941.JZkcHSQXDV@vostro.rjw.lan>
In-Reply-To: <1455788611-59790-1-git-send-email-qipeng.zha@intel.com>
References: <1455788611-59790-1-git-send-email-qipeng.zha@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, February 18, 2016 05:43:30 PM Qipeng Zha wrote:
> This reverts commit fe9a743a2601 ("PCI/PM: Drop unused runtime
> PM support code for PCIe ports"). To support PCIe ports
> runtime PM for Intel Broxton platform.
> 
> Signed-off-by: Qi Zheng <qi.zheng@intel.com>
> Signed-off-by: Qipeng Zha <qipeng.zha@intel.com>

No, this isn't the right approach.

I've already said that for several times and I haven't changed my mind.

Mika is currently working on implementing this in a better way, please talk
to him.

Thanks,
Rafael

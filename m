Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <55186A89.8090204@wvnet.at>
Date: Sun, 29 Mar 2015 23:11:37 +0200
From: Bernhard Thaler <bernhard.thaler@wvnet.at>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@linux.intel.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Len Brown <lenb@kernel.org>
CC: Lv Zheng <lv.zheng@intel.com>, LKML <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [Bugfix v2] x86/PCI/ACPI: Fix regression caused by commit 63f1789ec716
In-Reply-To: 1427267843-18710-1-git-send-email-jiang.liu@linux.intel.com
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I tested this patch applied to 4.0-rc5. APU.1C network interfaces are
working correctly again.

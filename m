Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Aaron Lu <aaron.lu@intel.com>, linux-pci@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Stephane Eranian <eranian@google.com>,
	linux-acpi@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Zheng Z Yan <zheng.z.yan@intel.com>,
	Dave Jones <davej@redhat.com>, Rui Zhang <rui.zhang@intel.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v3] Intel MCH BIOS workaround
Date: Thu, 24 Apr 2014 02:58:02 +0200
Message-ID: <1643834.MGNKT7oDCE@vostro.rjw.lan>
In-Reply-To: <20140423161901.16088.46695.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140423161901.16088.46695.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, April 23, 2014 10:20:57 AM Bjorn Helgaas wrote:
> Hi Rafael,

Hi,

> Relative to v2, this adds "#ifdef CONFIG_X86" around the quirk and adds
> Stephane's ack.  Either v2 or v3 is fine with me; whatever seems best to
> you.

I've applied this one, thanks!

Rafael


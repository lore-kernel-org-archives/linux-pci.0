Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 18 Jun 2014 06:26:15 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH 1/4] ACPI: Support _OSI("Darwin") correctly
Message-ID: <20140618052615.GA26873@srcf.ucam.org>
References: <1401640436-1947-1-git-send-email-matthew.garrett@nebula.com>
 <1401640436-1947-2-git-send-email-matthew.garrett@nebula.com>
 <7712179.sDPAd6Ubry@vostro.rjw.lan>
 <20140617144614.GA16934@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140617144614.GA16934@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 17, 2014 at 03:46:15PM +0100, Matthew Garrett wrote:
> On Tue, Jun 17, 2014 at 02:11:36PM +0200, Rafael J. Wysocki wrote:
> > Does applying this patch without the rest of the series makes things worse
> > or better on the machines in question (or perhaps it doesn't matter at all
> > alone)?
> 
> On its own, I think this will do nothing.

Ugh, no, sorry - on its own, this will break PCIe hotplug events and 
battery reporting. It should only be merged with the others.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

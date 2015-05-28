Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35430 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbbE1WIb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 May 2015 18:08:31 -0400
MIME-Version: 1.0
In-Reply-To: <4269355.CI4MW738Od@vostro.rjw.lan>
References: <20130725175242.6006.56007.stgit@bhelgaas-glaptop>
	<CAE9FiQXq59tSBM0SQ4OToXydZrRC3yukALmWEb6K9xpCGbdUhg@mail.gmail.com>
	<20150527193149.GD10210@google.com>
	<4269355.CI4MW738Od@vostro.rjw.lan>
Date: Thu, 28 May 2015 15:08:28 -0700
Message-ID: <CAE9FiQWDsQxKK3m4_-dSXm8V3xNc4oOtg2UQi=aayeKhLutwQg@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: pciehp: Convert pciehp to be builtin only, not modular
From: Yinghai Lu <yinghai@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	"linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
	linux-sh@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mundt <lethal@linux-sh.org>,
	Paul Mackerras <paulus@samba.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 27, 2015 at 6:30 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, May 27, 2015 02:31:49 PM Bjorn Helgaas wrote:
> For debug you can always use pcie_ports=compat and that will disable
> pciehp too.

That will disable AER at the same time, right?.

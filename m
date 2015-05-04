Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:34308 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222AbbEDMKM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 May 2015 08:10:12 -0400
MIME-Version: 1.0
In-Reply-To: <1430709339-29083-8-git-send-email-jiang.liu@linux.intel.com>
References: <1430709339-29083-1-git-send-email-jiang.liu@linux.intel.com>
	<1430709339-29083-8-git-send-email-jiang.liu@linux.intel.com>
Date: Mon, 4 May 2015 15:10:10 +0300
Message-ID: <CAPcc5Ph4pk+4aL-PduvF67YU-A+vn2bfx6v3mr-tbY58zs7sZw@mail.gmail.com>
Subject: Re: [RFC v1 07/11] net/mlx4: Cache irq_desc->affinity instead of irq_desc
From: Amir Vadai <amirv@mellanox.com>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Amir Vadai <amirv@mellanox.com>,
	Ido Shamay <idos@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Eric Dumazet <edumazet@google.com>,
	Hadar Hen Zion <hadarh@mellanox.com>,
	Eran Ben Elisha <eranbe@mellanox.com>,
	Joe Perches <joe@perches.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	Matan Barak <matanb@mellanox.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 4, 2015 at 6:15 AM, Jiang Liu <jiang.liu@linux.intel.com> wrote:
> The field 'affinity' in irq_desc won't change once the irq_desc data
> structure is created. So cache irq_desc->affinity instead of irq_desc.
> This also helps to hide struct irq_desc from device drivers.

Hi Jiang,

I might not understand the new changes irq core, but up until now
affinity was changed when the user changed it through
/proc/irq/<IRQ>/smp_affinity.
This code is monitoring the affinity from the napi_poll context to
detect affinity changes, and prevent napi from keep running on the
wrong CPU.
Therefore, the affinity can't be cached at the beginning. Please
revert this caching.

Thanks,
Amir

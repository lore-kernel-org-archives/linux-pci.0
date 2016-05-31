Return-Path: <mika.westerberg@linux.intel.com>
Return-Path: <mika.westerberg@linux.intel.com>
Date: Tue, 31 May 2016 11:43:56 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Peter Wu <peter@lekensteyn.nl>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Dave Airlie <airlied@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 4/4] drm/nouveau/acpi: fix lockup with PCIe runtime PM
Message-ID: <20160531084356.GH1743@lahna.fi.intel.com>
References: <1464130381-4797-1-git-send-email-peter@lekensteyn.nl>
 <1464130381-4797-5-git-send-email-peter@lekensteyn.nl>
 <20160525135535.GN1789@lahna.fi.intel.com>
 <20160527111037.GA1436@al>
 <20160530095709.GK1789@lahna.fi.intel.com>
 <20160530122010.GB1149@al>
 <20160530130909.GA1743@lahna.fi.intel.com>
 <20160530161351.GA1355@al>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160530161351.GA1355@al>
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 30, 2016 at 06:13:51PM +0200, Peter Wu wrote:
> Do you have any suggestions for the case where the pcieport driver
> refuses to put the bridge in D3 (because the BIOS is too old)? In that
> case the nouveau driver needs to fallback to the DSM method (but not
> when runtime PM is deliberately disabled by writing control=on).

Do you know what Windows does then? I think we should do the same if
possible.

If user has disabled runtime PM from the root port deliberately, there
might be good reason to do so. Why we want to fallback to something that
could cause problems? I mean _DSM on such systems is probably not that
much tested because everybody runs Windows 8+ and using standard ACPI
power resources.

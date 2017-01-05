Return-Path: <SRS0=Qt75=YT=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=Qt75=YT=linux.intel.com=mika.westerberg@kernel.org>
Date: Thu, 5 Jan 2017 16:20:29 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Wu <peter@lekensteyn.nl>, Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Kilian Singer <kilian.singer@quantumtechnology.info>,
	linux-pci <linux-pci@vger.kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Dave Airlie <airlied@redhat.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Message-ID: <20170105142029.GF3353@lahna.fi.intel.com>
References: <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com>
 <20170104081639.GA21076@wunner.de>
 <20170104210954.GA11946@al>
 <59349185.1aqio7kYFn@aspire.rjw.lan>
 <20170105104940.GA3353@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170105104940.GA3353@lahna.fi.intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 05, 2017 at 12:49:40PM +0200, Mika Westerberg wrote:
> On Wed, Jan 04, 2017 at 10:58:10PM +0100, Rafael J. Wysocki wrote:
> > I would rather add a quirk to the ACPI core to prevent the power resources in
> > question from being enumerated.  Or even to prevent ACPI PM from being
> > used for the port in question.
> 
> If we are going to add a quirk, I agree that it should be put to the
> ACPI core.
> 
> However, Windows seems to be able to use _PR3 just fine. So there is
> something that we are missing or do not implement properly which causes
> all the troubles. IMHO we should try to find out what that difference is
> and fix that if possible.

Here is one idea. The _OSC method is used as a handshake between OS and
the BIOS to enable/disable certain features. One of those features is
_PR3 support (ACPI specification 6.1 p.328):

  This bit is set if OSPM supports reading _PR3and using power
  resources to switch power. Note this handshake translates to an
  operating model that the platform and OSPM supports both the power
  model containing both D3hot and D3.

Some of our development platforms has BIOS option "RTD3 enable" which
is used to enable/disable this flag (among other things). The BIOS
should return acked caps when _OSC returns but we never check those in
Linux.

Kilian, can you try the below patch and send back dmesg when the system
has been booted? It should show if the BIOS acks _PR3 or not.

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 95855cb9d6fb..463eb2d69271 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -345,8 +345,15 @@ static void acpi_bus_osc_support(void)
 		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_APEI_SUPPORT;
 	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
 		return;
+
+	acpi_handle_info(handle, "Supported caps: 0x%08x\n", capbuf[1]);
+
 	if (ACPI_SUCCESS(acpi_run_osc(handle, &context))) {
 		u32 *capbuf_ret = context.ret.pointer;
+
+		acpi_handle_info(handle, "Acked caps: 0x%08x (_PR3: %s)\n", capbuf_ret[1],
+				 capbuf_ret[1] & OSC_SB_PR3_SUPPORT ? "on" : "off");
+
 		if (context.ret.length > OSC_SUPPORT_DWORD) {
 			osc_sb_apei_support_acked =
 				capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;

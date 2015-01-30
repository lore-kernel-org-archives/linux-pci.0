Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:48128 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759836AbbA3DHQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jan 2015 22:07:16 -0500
Date: Fri, 30 Jan 2015 03:07:12 +0000 (UTC)
From: Paul Walmsley <paul@pwsan.com>
To: Rob Herring <robherring2@gmail.com>
cc: Mark Rutland <mark.rutland@arm.com>,
	Alexandre Courbot <gnurou@gmail.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Stephen Warren <swarren@wwwdotorg.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Kumar Gala <galak@codeaurora.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 02/24] Documentation: DT bindings: add more chip compatible
 strings for Tegra PCIe
In-Reply-To: <alpine.DEB.2.02.1501291846340.16475@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.02.1501300306140.6569@utopia.booyaka.com>
References: <20150128234935.20644.89300.stgit@dusk.lan> <20150128234937.20644.9400.stgit@dusk.lan> <CAL_JsqKMm=r+57ShskgbtNqnCGF1yKYDSJJFQ7o05keNzh5z+g@mail.gmail.com> <alpine.DEB.2.02.1501291543030.16475@utopia.booyaka.com>
 <CAL_JsqLE+W+T5YqzdB+DkdBE+HsgySX0yJHzn1y43QDfw4GA9A@mail.gmail.com> <alpine.DEB.2.02.1501291707350.16475@utopia.booyaka.com> <CAL_JsqKaDi1cZN8Ndb0FPhvgRVFyxc1NRhV2cx-XJ323wTKiEQ@mail.gmail.com> <alpine.DEB.2.02.1501291846340.16475@utopia.booyaka.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi Rob

I've also updated the first patch, that tries to document what the DT 
maintainers' expectations are.  Care to give this one a quick glance too?


- Paul

From: Paul Walmsley <pwalmsley@nvidia.com>
Date: Wed, 28 Jan 2015 16:43:16 -0700
Subject: [PATCH] Documentation: DT: document compatible string existence
 requirement

DT maintainers require all compatible strings used in chip or board
DTS file to be previously documented somewhere in
Documentation/devicetree/bindings, per:

http://marc.info/?l=linux-tegra&m=142201349727836&w=2

Document this requirement in the DT patch submission requirements
text file.

This second version updates the documentation to align with
Rob's comments here:

http://marc.info/?l=devicetree&m=142255654213019&w=2

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Paul Walmsley <pwalmsley@nvidia.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../devicetree/bindings/submitting-patches.txt     | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/submitting-patches.txt b/Documentation/devicetree/bindings/submitting-patches.txt
index b7ba01ad1426..56742bc70218 100644
--- a/Documentation/devicetree/bindings/submitting-patches.txt
+++ b/Documentation/devicetree/bindings/submitting-patches.txt
@@ -15,6 +15,29 @@ I. For patch submitters
   3) The Documentation/ portion of the patch should come in the series before
      the code implementing the binding.
 
+  4) Any compatible strings used in a chip or board DTS file must be
+     previously documented in the corresponding DT binding text file
+     in Documentation/devicetree/bindings.  This rule applies even if
+     the Linux device driver does not yet match on the compatible
+     string.  [ checkpatch will emit warnings if this step is not
+     followed as of commit bff5da4335256513497cc8c79f9a9d1665e09864
+     ("checkpatch: add DT compatible string documentation checks"). ]
+
+  5) The wildcard "<chip>" may be used in compatible strings, as in
+     the following example:
+
+         - compatible: Must contain '"nvidia,<chip>-pcie",
+           "nvidia,tegra20-pcie"' where <chip> is tegra30, tegra132, ...
+
+     As in the above example, the known values of "<chip>" should be
+     documented if it is used.
+
+  6) If a documented compatible string is not yet matched by the
+     driver, the documentation should also include a compatible
+     string that is matched by the driver (as in the "nvidia,tegra20-pcie"
+     example above).
+
+
 II. For kernel maintainers
 
   1) If you aren't comfortable reviewing a given binding, reply to it and ask
-- 
2.1.4


Received: from mta0.migadu.com (out-128.mta0.migadu.com [91.218.175.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D4B3148BF
	for <linux-pci@vger.kernel.org>; Sat, 19 Sep 2026 20:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789851381; cv=none; b=Z4zUR2GC8vLUURz5rczDDlD+yGwt6yyW0bvxBYdxUpUfyLJ8y5f7PeppAwwJv6z59Km44tdV3xOZUZUcDWUpDOM7oqrljV9E4/ZAuuju8H7Z62p58BaTZ1hnhptghc1jwL/zVYyjzwWxaFUMk7rjkJjPmqBlJGLJ22QswpsuTKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789851381; c=relaxed/simple;
	bh=s7RTzfD2xYB6sexrdh1AVzvq6TnKbTUcVa0J8zWjqLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hkpwLwARUXiQVO6VlrU99y1FxY2T/bqMsZHCfH4crGIlxWiWokt87xa0zen/k1RocxbuHJ1c1Djo6WJe7I0SZ+NuvkzBF+ovdET23UA7yeeBdWv+gjJWRPtMf3xFLpqaZl0hTxlxHZaIzaMqPqqHwqGee1FiwAX13vCFmckGET8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cressey.dev; spf=pass smtp.mailfrom=cressey.dev; dkim=pass (2048-bit key) header.d=cressey.dev header.i=@cressey.dev header.b=F7Xoy6R9; arc=none smtp.client-ip=91.218.175.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cressey.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cressey.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cressey.dev header.i=@cressey.dev header.b="F7Xoy6R9"
X-Envelope-To: linux-pci@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=s7RTzfD2xYB6sexrdh1AVzvq6TnKbTUcVa0J8zWjqLw=;
 c=simple/simple; d=cressey.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789851376; v=1; x=1790456176;
 b=F7Xoy6R9Utd2dzi4IJfdlBJapA6STWy0j3NcE2b+2AOGOCnfxzBSb3+9+UCEP/wPDYf8igt8
 JjubFrinDkdBfSSC/u4fsP+codZArnB3rO4mMOuOLV7EXlnUrFYOv0zs90jGV1YPljOhjobfI3t
 oAZpT3vfw6cuDS8fyzl6/9P4prAw+TfkMlnTB8LdC30/rjvxMCqiSlCo/xJSfsYwQNUGSI9OWPP
 dagzOjBYTx49I83fAFletSy4jsk+TwFB7rJwaz+Tpqiu+HSNpVIdEu29EnskZvlPxbXi0cFU0Xk
 ta0SMfi1SPVw2a12bXXhVzE1jkCaBPVu3EtnHXHEPeYUg==
X-Envelope-To: linux-pci@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9ba522a53f9c0f58;
	Sat, 19 Sep 2026 20:56:16 +0000
X-Mizu-Trace-ID: 9ba522a53f9c0f58
X-Migadu-Flow: FLOW_OUT
From: Ben Cressey <ben@cressey.dev>
Date: Sat, 19 Sep 2026 20:56:10 +0000
Subject: [PATCH] PCI: Add ID@path device format for pci= parameters
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-pci-idpath-selector-v1-1-5881de83f248@cressey.dev>
X-B4-Tracking: v=1; b=H4sIAOn2rmoC/22NSw7CIBCGr9LMWtKWGC1exbgYxqmgDZChPpKmd
 xfq1uX3PxfILJ4znJoFhF8++xgK9LsGyGG4sfLXwqA7fehMb1QiX6SEs1OZJ6Y5itLD/ogDjmw
 0QWkm4dF/ttXz5cf5ae8lXKdqwmJmZQUDuSpNqaX4jvJgaTfrzwus6xeduGhJrgAAAA==
X-Change-ID: 20260919-pci-idpath-selector-2847a8afe92c
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Logan Gunthorpe <logang@deltatee.com>, Alex Williamson <alex@shazbot.org>, 
 Wei Wang <wei.w.wang@hotmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 "Anthony Vardaro (Anthropic)" <me@anthonyvardaro.com>, 
 Ben Cressey <ben@cressey.dev>
X-Mailer: b4 0.15.2

The <pci_dev> grammar shared by pci=resource_alignment=,
pci=disable_acs_redir= and pci=config_acs= names a device either by
address, with an optional path, or by ID. When one command line serves
more than one platform, neither form limits an entry to the intended
device: an address applies to whatever occupies it on each platform, and
an ID applies to every instance, such as all Downstream Ports of a
switch rather than the one that needs different ACS settings.

Accept pci:<vendor>:<device>[:<subvendor>:<subdevice>]@<path>, where
<path> is the address format, and match only when both halves match. An
entry written for one platform is then inert on another where that
address holds a different device. For example,

  pci=config_acs=xx111x1@pci:10b5:8749@0000:80:02.0/00.0/08.0

configures ACS on the Downstream Port at that path only if it is a
PEX 8749 port, and matches nothing on a system where 0000:80:02.0 leads
to some other device.

The path goes last since pci_dev_str_match_path() consumes up to the
next ';'. The <order>@ and <flags>@ prefixes of resource_alignment and
config_acs are stripped before pci_dev_str_match() is called, so the
callers are unchanged.

Reviewed-by: Anthony Vardaro (Anthropic) <me@anthonyvardaro.com>
Signed-off-by: Ben Cressey <ben@cressey.dev>
Assisted-by: LLM
---
This touches pci_dev_str_match(), as does 3/6 of Wei Wang's "PCI: Add
support for ACS Enhanced Capability" series, currently at v9:
https://lore.kernel.org/r/SI2PR01MB4393F337A792CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com
On current -rc this patch applies as is. If it is applied after that
3/6, the early return for a path that does not match needs to become
"ret = 0; goto out;" so the shared exit still checks and skips the
delimiter. I can respin on that base if preferred.

A pci:<IDs> entry with three or five fields is accepted by the existing
sscanf() and so bypasses the @<path> check; that predates this patch and
is rejected once that same 3/6, "PCI: Consolidate delimiter handling
into pci_dev_str_match()", is applied.

A backport of this change to a 6.18.y based tree was tested on two
server models from different vendors, both with PCIe switches whose
downstream ports share one vendor and device ID, and one boot of each
machine was examined with one command line that held config_acs entries
in the new form for both models. On each machine only the ports named
by its own entries were configured, and the bits those entries set read
back as requested, while the ports with the same vendor and device ID
at a path that only the other model's entries name were not configured.
---
 Documentation/admin-guide/kernel-parameters.txt | 10 +++++++++-
 drivers/pci/pci.c                               | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 33cd30996e47e..3e4c618427a27 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5042,6 +5042,7 @@ Kernel parameters
 
 				[<domain>:]<bus>:<dev>.<func>[/<dev>.<func>]*
 				pci:<vendor>:<device>[:<subvendor>:<subdevice>]
+				pci:<vendor>:<device>[:<subvendor>:<subdevice>]@<path>
 
 				Note: the first format specifies a PCI
 				bus/device/function address which may change
@@ -5056,7 +5057,14 @@ Kernel parameters
 				renumbering issues).  The second format
 				selects devices using IDs from the
 				configuration space which may match multiple
-				devices in the system.
+				devices in the system.  The third format
+				combines the first two: the device must
+				match the IDs and also be at the address
+				given by <path>, which takes the first
+				format.  This allows an entry written for a
+				device on one system to have no effect on
+				another system where the same address is
+				occupied by a different device.
 
 		earlydump	dump PCI config space before the kernel
 				changes anything
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f80..ebce05e604b88 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -343,6 +343,7 @@ static int pci_dev_str_match_path(struct pci_dev *dev, const char *path,
  *
  *   [<domain>:]<bus>:<device>.<func>[/<device>.<func>]*
  *   pci:<vendor>:<device>[:<subvendor>:<subdevice>]
+ *   pci:<vendor>:<device>[:<subvendor>:<subdevice>]@<path>
  *
  * The first format specifies a PCI bus/device/function address which
  * may change if new hardware is inserted, if motherboard firmware changes,
@@ -359,6 +360,12 @@ static int pci_dev_str_match_path(struct pci_dev *dev, const char *path,
  * legacy reasons and convenience so users don't have to specify
  * FFFFFFFFs on the command line.)
  *
+ * The third format combines the first two: the device must match the IDs
+ * and also be at the address given by <path>, which takes the first
+ * format.  This allows a parameter written for a device at a known
+ * address on one system to have no effect on another system where that
+ * address is occupied by a different device.
+ *
  * Returns 1 if the string matches the device, 0 if it does not and
  * a negative error code if the string cannot be parsed.
  */
@@ -385,6 +392,17 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
 
 		p += count;
 
+		/* Third format: the device must also be at <path> */
+		if (*p == '@') {
+			ret = pci_dev_str_match_path(dev, p + 1, &p);
+			if (ret < 0)
+				return ret;
+			if (!ret) {
+				*endptr = p;
+				return 0;
+			}
+		}
+
 		if ((!vendor || vendor == dev->vendor) &&
 		    (!device || device == dev->device) &&
 		    (!subsystem_vendor ||

---
base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
change-id: 20260919-pci-idpath-selector-2847a8afe92c


Received: from outbound.st.icloud.com (st-2005b-snip4-11.eps.apple.com [57.103.79.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F5B396B98
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 18:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.79.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787251368; cv=none; b=O7yLnPqtFefky5TzdCjj/5P8QUt9v4V+FAECJ7tCGo7zhj/S9fq4vYhBXiRcHVo06ubeNqnU+JEgEHPs1vprJoBOZe/F5AtNoQbyIYLA8TeZ1nGrBstnKYFq5w2ffnYhiIHyw7FJg258oYXXkCsfsfRLrQNQ49yPICe2Ahwta0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787251368; c=relaxed/simple;
	bh=eCGan4wbwwGU8/rjNmbzzX5c2lI3OsuQcukIG+B+u+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qflWEcOC96r0eU1M8eWVZg2KunrNyIzENEnKzqjPB8qALIK99DVLqSMrJFlLjrQmOtjtHf7K5b7zVlEcQEGrEE5vDD555QYVy64KoS8FkKEoVn8lhH5JHYWPyQGvVMLo/yjNULKpWVxPxPpz1vvAOUdnxvAUcOood6wEDhR48Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=jLSFNs89; arc=none smtp.client-ip=57.103.79.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="jLSFNs89"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-0 (Postfix) with ESMTPS id 5E5491800320;
	Thu, 20 Aug 2026 18:42:41 +0000 (UTC)
X-ICL-RepId: 01a0207b-861d-7f94-bc86-8b88515fbbbf
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQhABkMAWBxBDkkdXwZfEhVdRVUIRRlTHhccRgxFGVswVB0dDlgGEhZdRV4IGQhdHRkKUFACS1oVVRcOAkIfUB9MFldDRB8cGVoUXBhTRVEfVFhDGUVWaUELTx1dGVscQmRYVwkKBldeWhdeTVoCVk0FSgNfAVsKQglJC1kFWQpeCE4FWAFdH0EUHlYfRQpcXl0NUh9FAnIdXFZQAlpVEgRACFZQXgheH0wc
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1787251364; x=1789843364; bh=J1nsQnOeV2cC7KMcXVvWjMqQ/3Q1TXdBakIwyZPzX8c=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=jLSFNs89qjKXvDj2rsVqo4Zqy1w1qeYIWL+EDb1XSOKwDJigPbHUdWBsaWI2jyXlDjQ7YIgcfnvXLkmF8j5KNtoVIUdbP3VOT6bbILCYysz2s3Kyw2gk0mzliEVFGp7ZTIgXc5LzDbmTuKh4ZlEHh1FDHkkKLceBqjIVBPpMqn+/q/QzAYMLkxBJ/88WofzAFPPnTlPfvV4eUW1TArujt5tr8+ZugIJsNXKoRqFXoXL5DMvTrixP3rxf7tHFp9Je8meoxu2c39nKbAhB7wtVAQ3ihnqOv/AvazYqENKrputVy79HqeNrf1BMEW1MxwLHaBqXLMXtqerbysaMLuiSNw==
Received: from ncore (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-0 (Postfix) with ESMTPSA id 6A0811800D4B;
	Thu, 20 Aug 2026 18:42:35 +0000 (UTC)
From: Ferran Duarri <ferran.duarri@me.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ferran Duarri <ferran.duarri@me.com>
Subject: [PATCH] PCI/sysfs: document the link speed and width attributes
Date: Thu, 20 Aug 2026 20:42:26 +0200
Message-ID: <20260820184228.166566-1-ferran.duarri@me.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE0MSBTYWx0ZWRfX8+z0/KfSXKtZ
 ZXLc8ObbFD74z8txfMC5kfgeWtrHZpSPOEn1BCQU74fs1YB6bqKPieq9Ey+EJpKghBdLk/dpEHv
 EsFc0pFPlt2mnAVMtrRUUnmfauAKjSerGms7TXYdqU6rhHsYjNV29dPlV7wOrSkr0RokMGqEmmp
 U+JK8oKXL/I0CFbSeuzrRGNADuJtEaQbkRVHtMFwY1MoaA4E0OSb6eqOkJGTJWuQ9WzPR4OmO9X
 ZIwuDCrZCgAPTGSBIUA73eKgZeTC9k+B6m+ypx/GGlWHxpark/tbjX6vlVKI9iqRQWMge7eFeqb
 8+8eDpu/3M8I8+JnwMT+00Ao6VadpXBcZWZq9ogA0wq13+tGVQvb3tUaXwCp9A=
X-Proofpoint-GUID: s0Li-e6EnCK06dN7CvL2p8T4vO4YwObE
X-Authority-Info-Out: v=2.4 cv=FvcIPmrq c=1 sm=1 tr=0 ts=6a874aa2
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=B9nqV3Rn1-QA:10 a=VkNPw1HP01LnGYTKEx00:22 a=HHGDD-5mAAAA:8 a=VwQbUJbxAAAA:8
 a=TXvrxmDOgE7bbrmoIFIA:9
X-Proofpoint-ORIG-GUID: s0Li-e6EnCK06dN7CvL2p8T4vO4YwObE
X-JNJ: AAAAAAAB4/PZVDUrj9y30PWH4dIVtc9rch9ftydE+uFv2s6G8qArLtC3YtHKbJ5W4n4DZIgywau/qi826NP8aNmdOMa3BUmIzjVgnEd8Vj459xZeInoEzArq5cOC1I9YchB5YwNB9TqDWyDoDEKRCAtANDxXL2RTOUyIMykveu/wb25rMmBDiQxHzJCOc27YxajQYFvA+mCLr9DrLywLRSvkuJPfSO/85ZTXUc8AsnbABO7VhUPtW+7nX9SZMxYaLeIQ+HqYIYsqH9uRU5eb4uzHC2m4ARQlqkzPpww9oNaFOHAjPOc3wEAi8iXey5CigdZKTMPYTE1Jf5obfErX/3DRkFmpdAKfJytedajhnhjiBsWfYTbKqCFMojMVNCw69wohsYavIrNadQZWLEXi9Z/HzrZ+3a9sTlAmGkpBzwEyqwgLHQNgsZsOW3d5ovnFs8vz855CE4ksQgULnNHU3HBvwSrk+SqvtA357hcoFbpw8LApzpbn6btQlelKz8FGKeZeGyp84P8ZbclEy8yatms1ds13vOeUEL2PQ/ydORvxKLFPlxi8E9bSBAhDAzLAjGfFDFQKMdaG4Gd9EYfW2Clhqr5161JIgaCBtHdtzL583fRLPaVfXqnG6rMQuRl4ghzGLsg/AZ5MBB5g9KqLzEVbgE7FnRnxsSGoHfoJTrxEexb4ITCxcVT3dd9BfHQ8Dwhg9jhC7pvM7fNlDMoV13BtIkEnK3I4uQuNuvNFD3ULExUUg1XiUBDC+VA2aVhbijtJYHUaukvLiEBgzI7PfBmI0vNMJ0dAMtyAkd0Zan7tSOg0g12Nsas7Wr5xfn/ehBcVQRyo4+cQcIfyH9ZlehCRAnI7goWqMFEtIl3t+I8VFMgg7fd1J5B9s+4mCB80u7DxYMEnqKcvFC0j9gku4kkwPM4kYyG87uplFet3UO15qOFH9bnbmddV8jnNLh7TOd+NwfXFGXaBdA6iYwqZiLvRae45sZP
 iElfFvz/Pwe+jpm/dsIhwupVB3xSko4ZyJIu00UAlIGm8ybJ//HiBzEMxFGpKj7/65lNuxCoJQEhssMR4Mr9ZWTCCXSTUMoxZO5N+3R8opA8j2BRBa+1waFWSqH6TwIJIYMVTE7k+NqLfb2jkm9G2wyHj1U/Br09QEjO00YwXvZ6ogrJdhnw5QOz29o2JnKoDUwzjmg==

max_link_speed, max_link_width, current_link_speed and current_link_width
have been exported under /sys/bus/pci/devices/.../ since 2018, by
commit 56c1af4606f0 ("PCI: Add sysfs max_link_speed/width, current_link_speed/width, etc"),
and none of the four appear anywhere in Documentation/ABI.

The gap matters most for current_link_speed. current_link_speed_show()
performs a fresh PCI_EXP_LNKSTA read on every open, so the value reflects
the link state at that instant. Modern GPUs retrain their link continuously
as part of idle power management, which means a single read can legitimately
return any speed the link supports, not the speed the link will use under
load.

Observed on an RTX 5070 in a PCIe 4.0 x16 slot, same boot, no configuration
change between the two reads: 5.0 GT/s while idle, 16.0 GT/s under load.
Comparing current_link_speed against max_link_speed at idle is therefore not
a valid test for a degraded link, though it reads like one.

Document all four attributes, note that the max_* pair is the ceiling
negotiated between device and platform capability (so an endpoint's own
capability may be higher than what max_link_speed reports), and state
explicitly that current_link_speed is instantaneous, that comparing it
against max_link_speed at idle is not a valid degradation test, and that
callers wanting a stable figure should sample under load or use the max_*
attributes.

No functional change.

Forward-Port-Notes: Documentation/ABI/testing/sysfs-bus-pci
Signed-off-by: Ferran Duarri <ferran.duarri@me.com>
---
 Documentation/ABI/testing/sysfs-bus-pci | 65 +++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index b767db2..ad18bd6 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -174,6 +174,71 @@ Description:
 		similiar to writing 1 to their individual "reset" file, so use
 		with caution.
 
+What:		/sys/bus/pci/devices/.../max_link_speed
+Date:		September 2018
+Contact:	linux-pci@vger.kernel.org
+Description:
+		The maximum link speed this device's link can operate at, as a
+		human-readable string such as "16.0 GT/s PCIe". Read from the
+		Max Link Speed field of the device's Link Capabilities register.
+
+		This is the ceiling the link may negotiate, which is the lower
+		of what the two ends of the link support. An endpoint capable of
+		a higher speed than the port above it will report that higher
+		speed here while the port above it reports the lower one, and
+		the link will train at the lower of the two. To reason about a
+		link, read this attribute on both ends.
+
+		Present only for PCI Express devices.
+
+What:		/sys/bus/pci/devices/.../max_link_width
+Date:		September 2018
+Contact:	linux-pci@vger.kernel.org
+Description:
+		The maximum link width this device's link can operate at, in
+		lanes, e.g. "16". Read from the Maximum Link Width field of the
+		device's Link Capabilities register.
+
+		Present only for PCI Express devices.
+
+What:		/sys/bus/pci/devices/.../current_link_speed
+Date:		September 2018
+Contact:	linux-pci@vger.kernel.org
+Description:
+		The speed the link is operating at right now, as a
+		human-readable string such as "16.0 GT/s PCIe". Read fresh from
+		the device's Link Status register on every read of this file;
+		nothing is cached.
+
+		This value is instantaneous and may change at any time. A link
+		is permitted to retrain to a lower speed and back, and devices
+		with aggressive link power management (GPUs in particular) do so
+		routinely while idle. Two reads seconds apart, with no
+		configuration change in between, can legitimately differ by
+		several generations.
+
+		Consequently, comparing this attribute against max_link_speed is
+		not by itself a test for a degraded link: an idle device will
+		frequently report a lower speed and is working correctly.
+		Callers that need a figure representing what the link will
+		actually deliver should sample while the device is under load,
+		or use max_link_speed if what they want is the ceiling.
+
+		Present only for PCI Express devices.
+
+What:		/sys/bus/pci/devices/.../current_link_width
+Date:		September 2018
+Contact:	linux-pci@vger.kernel.org
+Description:
+		The width the link is operating at right now, in lanes, e.g.
+		"16". Read fresh from the device's Link Status register on every
+		read of this file.
+
+		As with current_link_speed, this is instantaneous. Links may
+		also narrow and re-widen under link power management.
+
+		Present only for PCI Express devices.
+
 What:		/sys/bus/pci/devices/.../vpd
 Date:		February 2008
 Contact:	Ben Hutchings <bwh@kernel.org>

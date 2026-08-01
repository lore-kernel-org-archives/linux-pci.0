Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E4E302163
	for <linux-pci@vger.kernel.org>; Sat,  1 Aug 2026 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785607838; cv=pass; b=qht2KngFJSYwg+IwECfrQNu1mV7K0HcwjDy6RifYGB/IGooIsgTr7L//rbFRm5T0olPLTThPl5wjNo1tj0jvMjguu8ULw/OmLF5ysPh4KNRaurnxoUT5wMAXjhtLntM6Mmlcqvl2wLIoOHq6HS4YilWyoJ45/6befTKpmGRA6sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785607838; c=relaxed/simple;
	bh=1pJUL+6M77HJJSwvYET+wCwQPOdaQdNQKcazVTQ5JcE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Dar/E0yGfhYcbxkFBMCN1EYHh3ctFR5nksVuxyrjqIlDNEh79fZPgoqWjeovxOEGfJ/TlxdfhwnJ0Qt5hYqvdpgtZDkDGAKLdD+dCdyYIT+fqMnyoRbsgb9PRHg+g4A4dEOCgYx/riCWsIILX9f3ZUkcJMhUfhDdhZv81ya6BO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Anj6znZh; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Anj6znZh"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81e83f1f15aso26449907b3.1
        for <linux-pci@vger.kernel.org>; Sat, 01 Aug 2026 11:10:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785607836; cv=none;
        d=google.com; s=arc-20260327;
        b=YMa1VzsLwvGb28ZstuuFGythUZWkvdkoZEJSfLYCj4iA3G19OHK34JfKoFsiEb+qIW
         AC0UBEF4jXs7GBbPaXILhtG7Vvy5nchVcPnGzGpf+WGjSnx0lQFG8fHkcUF7Hij2AWWS
         WEeeRMgkjI2WD/PKm01DtYXwmHh5ENx5fRxCcQlwY98uYGYoFEKWP1APP9EjMJnZpB73
         aub+FKkAelPsJ5ikrK6qlIEbOV5ugICRP5kxajymDmQU0IHmPRm7VUBMZhqGc1OgSYsX
         3e/551o+adSX8yMO+XwZ4zACdU4rEfHdzLmYb3ENRiFs+onEJT/c15yUiHOJk0I/BIQt
         A7cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Z//lxeCT8ePj6eHKiEj9CETIwlIlzc5JUSwHAQz4uXM=;
        fh=PJtlSO8JNUph17sPlzp4UhMfJWJkvw090Gr2Rv/iq+A=;
        b=Oed/Vc3sYqoVO2sMlnSDPJ8XKOmLhAKt7uaUELp4Z5oUxB1Uqs6azyanpIfxj2DmdO
         WpBZ5te13J9+Tc8Th6oSz8Z9fatiCr/LUrd3PMggR39BB1GlbyP4h/uGAcUuKUVduUHc
         t29dpi2dSXKGwzztZZQNmaal8uPGloNLyR52elVB7TMEtL8Q2vit+U78zkArD4yUT0VB
         R4eixAW604SScdkdKB5FXbUCHN6WFW8XfwAz35tnFDJQ5uKyJl9EmnKNNs5ADM15G3P+
         JxzrIdDHdElXl9isIX6z8m00VquNet27QquD4lGYRT9837lM4cmQ0JmvuVx/kCyPQ5ri
         B3lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785607836; x=1786212636; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z//lxeCT8ePj6eHKiEj9CETIwlIlzc5JUSwHAQz4uXM=;
        b=Anj6znZhkyLG0cqT7Hs5QTtDhyfj4vdBhfmSG1xdfWDH631CwTXx5zipsavPAoBobY
         EYOjXkWmBykDbJLpeFAUEnXQyFnWZUJJ2gXnFIyZuAhSDeeMvfCaCGBEXhV4+yhF9f6J
         6lG1RfHP+SwD915BHx9gWZtxtQVUliW/avsS3HmbY2+9f4ygVnagpiuiT7hrtIQ/nDot
         l32wSlUeCqpiSnTka3VW+cDyUsGfBHDHcNrTZ+U1I3w2MIi8Kj0EcyqW8YVENJY/yWBi
         elN5+Bo2DNblW9DMmbXNYfG4wn1VEVF4WPMiK48TqntjIK2ogQVKl0Czu3HvA5816X3E
         U/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785607836; x=1786212636;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Z//lxeCT8ePj6eHKiEj9CETIwlIlzc5JUSwHAQz4uXM=;
        b=sXto/e9fvo5JLF+UwRhkCEpuMIgM1RJuSby/Mr3ZSLFa8S8HX+tr1UkBUo2ITHroVV
         CrmPHcF9Z6xlkpZ4jJi3zLn/osrWB3KC+ab5BTMEi2btQGSHwE/wbsIsq8arVzGvo9GK
         wIKwJyCl7+6kLAKIqh3JvRusjqevXH1leWBS++AsETXhslaW50YWsLRDYfH/dMxx0oMS
         03WS9v/ft/mOlkWhsREsRCStGulNRvnv5ybK0sZCCGH9W4Bo56DjjnmdcLbSUdkd61Jd
         cw3JERIsfj1bVE5gNsO9YLSjYa02b+oX5FL17146LbW6tfQtwh9lbmGnKPjrD/5UC04x
         QcWw==
X-Forwarded-Encrypted: i=1; AHgh+RpX+MbPifyxcCZWGct/qLqgLfaY3Um2qa/6tR8Lwgu6XarH+GXiPdGUEEu0z7R4/jvvk/drWSweFgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOvmyNXRlHxAKGkt/paVnSwGezXYpJOxVx5VatvHQbYk5tAxrE
	z0Edf9AUWtR/QJ4MaTqjT44BxXLXC20F5YxQv/3xFTnumy6Q7/AgINqQyw1r2L00dfB8RtSRPb6
	N/dd33J5ndO30I5wOz1EBvPUhl9KCqeOamgoZSgKKaQ==
X-Gm-Gg: AR+sD10DInNNDkVRR1ey4aK054FZ4zsKXLQ8XR/xa22qA+KMkT1TmDSkx1bZeEwMcYc
	bwmSGSmEMgUtKPheIhF8/yznSG/wgZVIEh7I+t6uOxbnGICoHQ+voFVU5NbuDHQ0yYZ8B2sS1EU
	Xexq2ZKKO6nL2aSUz4IJQcofYq/e/bIG9ScjLSxhKUyuqN2nqHjHGtrUwZvRZriRG2AYSOGrkrT
	VSaQRWtVD5yRwMkWrBOmuCGkpdXSPRuknw5i0ad7Oj/tOkoopU1GIw0e+N7GPUVsrgmLsL3LdgQ
	vjYWe4IPY1hpCTuIPJhbIuwCv6AQvKV5RjL/VGmi0bU/Qean4cr5sKyWIaYFD0GmCcTPRoLTd5K
	51jWqJSiwyQ==
X-Received: by 2002:a05:690c:6284:b0:81e:fc6c:452c with SMTP id
 00721157ae682-81fd4e78d70mr64043627b3.9.1785607835997; Sat, 01 Aug 2026
 11:10:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lowne Onema <lowneonema@gmail.com>
Date: Sat, 1 Aug 2026 20:10:25 +0200
X-Gm-Features: AUfX_mxUGwzxNMgfJt9bkzwcd0YVqyIfkGBoYw2uS1Lnjoh8hWSejVwJphLpoeo
Message-ID: <CA+1pjEmQgcfhjj56yjuXWVshBM+soFC7RZHaGwaaF=ZFCr1Lyg@mail.gmail.com>
Subject: [PATCH] PCI: quirks: Prevent D3 for Acer Swift SF515-51T Root Port to
 fix audio
To: bhelgaas@google.com
Cc: lukas@wunner.de, rafael.j.wysocki@intel.com, alexander.deucher@amd.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for D3 if
power managed by ACPI") made Root Ports newly eligible for D3 when
ACPI reports the port as power-manageable. On my Acer Swift
SF515-51T, this Root Port (Intel Cannon Point-LP PCI Express Root
Port #9, 8086:9db0, always empty on this SKU) is put into D3 as a
result, and doing so permanently silences the internal speakers
until the machine is rebooted.

Disassembly of this board's ACPI tables shows the Root Port's power
resource (RP09.PXP) and the SATA port SAT0.PRT1 share GPIO pin
0x0402000D as their power enable line. That GPIO also gates a
rail the internal speaker amplifier depends on, but this dependency
is not expressed anywhere in ACPI -- HDAS._PR0 only references
PAUD, so the kernel has no way to know that putting the Root Port in D3
cuts power the audio codec/amp circuitry needs.

Prior to commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for
D3 if power managed by ACPI") this Root Port was never trusted for D3,
so the missing dependency had no observable effect. Confirmed on
hardware: forcing the port to stay in D0 (via
/sys/.../power/control) restores audio immediately, and letting it
re-enter D3 reliably kills it again.

Use PCI_DEV_FLAGS_NO_D3, matched to this exact model via DMI, to
keep the Root Port in D0, following the same pattern already used
for other model-specific D3 breakage in this file.

Fixes: c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for D3 if
power managed by ACPI")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=212463
Link: https://bugzilla.kernel.org/show_bug.cgi?id=214125
Signed-off-by: paasshme <lowneonema@gmail.com>
---

I went with a DMI-matched PCI_DEV_FLAGS_NO_D3 quirk since that seems to
be the go-to pattern in this file for "device breaks in D3" cases (I saw
quirk_no_ata_d3 above it). Is that the right mechanism here, or would
you prefer something scoped differently?
Apologies in advance for any formatting/process mistakes, that's my first patch.
Thanks for taking a look

 drivers/pci/quirks.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b09f27f78..feb83a84b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1471,6 +1471,41 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_AL,
PCI_ANY_ID,
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
                              PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);

+/*
+ * The Root Port that the Acer Swift SF515-51T's internal, always-empty PCIe
+ * slot is wired to (Intel Cannon Point-LP PCI Express Root Port #9) shares a
+ * GPIO power-good/enable line (0x0402000D) with SAT0.PRT1, a SATA port, per
+ * this board's own ACPI tables -- confirmed via DSDT/SSDT disassembly, not a
+ * naming coincidence. That GPIO gates a physical rail that isn't documented
+ * as a dependency anywhere else in ACPI, but real-world testing on this
+ * exact hardware shows it also feeds circuitry the internal speaker
+ * amplifier depends on: forcing this Root Port to stay out of D3 restores
+ * audio, and putting it back into D3 reliably kills it again.
+ *
+ * Before commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for D3 if
+ * power managed by ACPI"), this Root Port was never trusted for D3 at all,
+ * so the missing dependency was invisible -- the shared rail just stayed on
+ * incidentally. That commit's broadened trust condition lets this specific,
+ * always-empty port enter D3, silently cutting the rail and killing the
+ * internal speakers.
+ */
+static const struct dmi_system_id acer_sf515_rp_d3_dmi_table[] = {
+     {
+             .matches = {
+                     DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Acer"),
+                     DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Swift SF515-51T"),
+             },
+     },
+     {}
+};
+
+static void quirk_acer_sf515_rp09_no_d3(struct pci_dev *pdev)
+{
+     if (dmi_check_system(acer_sf515_rp_d3_dmi_table))
+             pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x9db0,
quirk_acer_sf515_rp09_no_d3);
+
 /*
  * This was originally an Alpha-specific thing, but it really fits here.
  * The i82375 PCI/EISA bridge appears as non-classified. Fix that.
--
2.34.1

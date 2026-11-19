Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795049561;
	b=hW/9dx7zk3cMmI+V21sEALlN6eqd3RYxTosd4Vny8T6xdBhdNRcDMzDWZ7TSJ8QCi5XX
	 3HSYcvdb/uUysoFnz6AAQbVujx4OUNrADuN38KPFyOJ4Lr9n1fUMISpaCP10NZLLNsK71
	 z2oscMT8dM7P/2QKLNq75auJ4UXO7A+KvWtXLdvrn4EKSH59XhVy0wPnZuN11Jgly8dbf
	 iXz58fI0RnzUnuSD0a9E/cDjt42ZhyJK2Y/V54uzGhRr1+t4dIpFmHwDGCNYxPlOL0oUM
	 nssRI4X2n29MGBod+QWXAf/9kyZPJRm3Co1OKi9gHLUuAq7skE9bPkMW4UFMRuNSOXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795049561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=nymuC/5fpi5YK3jj3hRmkBJgLlOLdb1iU6gNf70BLcg=;
	b=wM4zXTsGZa4nqYgZGe9Ban0KJMGhw10IY0hjdpKrUdG+JRCQDVU8zaDPs/zJwByQ7UiR
	 AjH57zTuW6Cy4dHN3r37uyh+c6cvksf3zdUW8w0E1dUDyQRjrq1CstQz0dtsB7Ue9b0Dx
	 lOG3oak/Ugx8kX8wEc4POLlm6jn0JWt7Z+GDEcl+sk1/12CQu9/PwhSktMINv093lRGJE
	 iL55y+zLTDC7ed4LCb4isd5HE+EqsvOhszpvMlUHAq7qc3l6kQM9+vMVEA+q+YnAa6IzG
	 hTKlngAoktazvnUPtTXum+kfRVESTxJ+01YJhmQF9eqxwAybj4o7WglZlfKifuO3k8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Iq316Y0b;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90B4606A32A
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 00:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E90B4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Iq316Y0b
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-94962d80d34so122923285a.2
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 16:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795049560; x=1795654360; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nymuC/5fpi5YK3jj3hRmkBJgLlOLdb1iU6gNf70BLcg=;
        b=Iq316Y0bGlG+Icqd6RlOOuDf9DVXgglC1lbVWj5XkNFRNyBPF0VU2Uk4yLsX227t/i
         30m+0cYjgW3Y5k4GdEpqgt9couiCwmgqE0Lrzq28r51Kex8/sfBmFgIvurFE/DtaY2AC
         cHTcwZIhaSvTfS30bI8NeudaJ7MLk7bQXl+Qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795049560; x=1795654360;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nymuC/5fpi5YK3jj3hRmkBJgLlOLdb1iU6gNf70BLcg=;
        b=nRpa2AcZtwyxp5TMrPQ6Fyatf+AwnW6JvI+XCgw/ck8lQ7/HhwQem2Tmz7WZ3DpfEQ
         nRg4nZeFKkFxse8ZiD0uwV8AHELdxKc/Bdcl51mBlhsEub/+eRonVJ900MhitjcX4d+K
         cvtAKzqUXYKzxQtyfxieAM8uNrbXPXOTnj6rRabhit0m2bAo3Fz0Caieanf2X53sInAX
         nXXacyDps9xa64wV3IR6jXFjNVuq0gzTJ6g6cBy8nkf61ngJ3Ta0O335q+gCWNfzFFj8
         +DEDvSM3hUqD8Nm+5ejHH9y1tS+F8ORSamZM3yU4XRGZu2PnjC8xLi4piAlpED7h39eo
         ZdJA==
X-Gm-Message-State: APuU4Z/zACbXG50IvJoqxbTAGHdeV2ibcGPkczPExaerXOAee/LKMBj+
	il3f8gVyCOiOuhP7kooTbhTd1S6C9CTrRdGbFySfsQo6yvsIVZeiNEt+5H2UuW38eg==
X-Gm-Gg: AYBFou1qQxlTfK4IcW5MfWUiNZok5x38nzWebtjLLZ/kgYR0wSziGJNna0aslcsA9Jo
	Q1CLpvMRB+v/bXoTzHtmePZc0ih85oIaVWkk7JqZUPOITtATmgqCjfV0BfOSQnwKKrKYIzBjqNQ
	GhaKrwS/TWXgwNprxfMjeDFjcs3htGQnkoY0Gzos6bXUXLjpDJD3gfdzW/Yj5X5mOcR2+82pyQ6
	Xl4i3txclau9xjKXvnwQmN5+5/3R6yJauYtnMu5Vu1zeJMA4jebH/FRwfpul9iP9oKmXj0pZhnb
	eOh7ER2NnJ2bUz9pjR59xeFhSB5tY/BsiPPK3SIewjYGIVJCgjUkUPR3vUnKW2Y8xmGzWf4JMjj
	o48EIZ4cwjd4U3zUnlnMCYFQZ3D4MpNokkiICCy2Qk7K9kVFFl4pIr5dF0feMPWiCF/ZXivwnNO
	fmsYIG1vb+sQ3LwS27TGsziYlC8ZdABsdw1eTO5joHwk/qATdlJdHFJokCRb+0uE2lHkCtWdD+U
	j3kWIJSc5aIutRFGjt4qbqY2fIISUPLa+cXVGB9xOGlQ4Ni4VfO2gSLn/FmVuy2cPsX/jGE0lQ6
	Khtb2VyQI8GL8DCIdS7h2+zTRFswgVMlr99FObcqhY6ESB2JN2r4ysRgArNQeY+dyEvjtyVxNKP
	zgFPDaRmSFVg=
X-Received: by 2002:a05:620a:2586:b0:943:e946:8c6d with SMTP id af79cd13be357-94999667470mr875646085a.72.1795049559815;
        Wed, 18 Nov 2026 16:52:39 -0800 (PST)
Received: from ripwilburliny3.c.googlers.com (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b818399sm308860785a.42.2026.11.18.16.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 16:52:39 -0800 (PST)
From: Steven 'Steve' Kendall <skend@chromium.org>
Date: Thu, 19 Nov 2026 00:52:19 +0000
Subject: [PATCH] PCI: Override Intel Apollo Lake audio class on Gauteng W3S
 laptops [8086:5a98]
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-gauteng-audio-class-set-v1-1-e81d6fd620ad@chromium.org>
X-B4-Tracking: v=1; b=H4sIAEJI/moC/yXMwQrCMAyA4VcZORswVSvzVcRD1mU1Ip00rQhj7
 76qx+/w/wuYZBWDS7dAlreazqmBdh2EO6coqGMzuL3zRNRj5FokReQ66ozhyWZoUtCd/HT2fWA
 6HKHVryyTfn7n6+1vq8NDQvnuYF03yQyccnsAAAA=
X-Change-ID: 20261119-gauteng-audio-class-set-256f769ca134
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
 Steven 'Steve' Kendall <skend@chromium.org>
X-Mailer: b4 0.15.2

Gauteng Education Dept MODEL-W3S laptops advertise PCI class 0x040300
to use the legacy HDA driver rather than the Audio DSP on the Intel
Apollo Lake audio controller ([8086:5a98]). However, this board uses an
I2S ES8336 codec with no analog HDA codec, and its firmware otherwise
sets up the hardware to enable the DSP.

Add a PCI header fixup for [8086:5a98] on Gauteng W3S systems to
override class 0x040300 to 0x040100 so the SOF driver can claim the
device. Notably this fixes the internal speakers and headphones but
not jack detection.

This patch and its initial changelog were generated by Gemini during
an interactive debugging session given dmesg, lspci and similar
dumps from Gauteng W3S and MODEL-W3S laptops. The resulting quirk
was reviewed and tested on physical MODEL-W3S hardware and on a W3S
with slightly different hardware.

Signed-off-by: Steven 'Steve' Kendall <skend@chromium.org>
---
 drivers/pci/quirks.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7f1f47ea2ee4..908d038fa29a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -754,6 +754,40 @@ DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, PCI_ANY_ID,
 			       PCI_CLASS_SERIAL_USB_XHCI, 0,
 			       quirk_synopsys_haps);
 
+/*
+ * Gauteng Education Dept MODEL-W3S laptops report PCI class 0x040300
+ * (PCI_CLASS_MULTIMEDIA_HD_AUDIO) on the Apollo Lake audio controller
+ * ([8086:5a98]) even though the Audio DSP (BAR 4), NHLT ACPI table, and I2S
+ * ESSX8336 codec are enabled and no analog HDA codec is present.
+ *
+ * Override the class to 0x040100 (PCI_CLASS_MULTIMEDIA_AUDIO << 8) so SOF can
+ * claim the device.
+ */
+static const struct dmi_system_id gauteng_w3s_dmi_table[] = {
+	{
+		.ident = "Gauteng Education Dept W3S",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Gauteng Education Dept"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "W3S"),
+		}
+	},
+	{}
+};
+
+static void quirk_gauteng_w3s_audio_class(struct pci_dev *pdev)
+{
+	u32 class = pdev->class;
+
+	if (dmi_check_system(gauteng_w3s_dmi_table)) {
+		pdev->class = PCI_CLASS_MULTIMEDIA_AUDIO << 8;
+		pci_info(pdev, FW_BUG "PCI class overridden (%#08x -> %#08x) so SOF driver can claim this instead of snd_hda_intel\n",
+			 class, pdev->class);
+	}
+}
+DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_HDA_APL,
+			       PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8, 0,
+			       quirk_gauteng_w3s_audio_class);
+
 /*
  * Let's make the southbridge information explicit instead of having to
  * worry about people probing the ACPI areas, for example.. (Yes, it

---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261119-gauteng-audio-class-set-256f769ca134

Best regards,
--  
Steven 'Steve' Kendall <skend@chromium.org>


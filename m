Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792886929;
	b=STcOJGMH3Wwwuh2qnbKtJESYg+Dap4FgAI9GD9t0FKHUqJLFxKcDTd0TYGUxOOsibU2F
	 LeQIeETVg+GGXnuAySNGXJw84PRGgNyaO29yTpixNoGJ9HQMHQ5XgsCAjV9+UCrikP21y
	 iJH//V+5vl0rh3k083m3sv1H2ehFntM48P+kXokJtKAQPgcPsfdum/+fETKc+vB4rvTjQ
	 mIFIJK+HPIsEe5RA3dp35pFeHPkbKImAwkZGsqPXu1fNy8SHYPftwqzVZqzOYRFneU4tZ
	 7XZznm+RKsfh8vUBZwifBsFKVZR5cdMUrKZu4CvKYOOdxMdbceMCWvf/qW3fiPPRylw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792886929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OSC4ftnTo6YGV1dHbcFRy9QyJa8EnMoA6aGGO4fBdTk=;
	b=2jvgSA+T4IANsKFPZNmQteVIX9YKfuFocll3Weq6NdcTOLJnqpO1G3+9S3if9yVj734S
	 qCpWi1jm0xNZbs7AHGKL0IMS6/f7jyrjpgfY094YSW+vppx2s8SMt8YiUBlJs/YbI1LNe
	 bhPvKvAmxnflyh7j1NAiTvEuTjTUlOC4Y+JkqvcBQ6hHGdjpfp0jJ103NNBVwuAsGP9o4
	 TkzAUK2Pofkw92ZQ4b3knKbSbFAuL9EGe2EjKW3mHs+qmtynOMHoZqEfl/wvXI5Tl57IR
	 WSuwF1jzmOIlcj4Rsb9Qb5ftLp67WQZbdEapBmPCHCJQ0zI1yR31l+tCLeeq8NTFhkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a4kyn1Rs;
	arc=none smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ED3606A332
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 00:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7ED3606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a4kyn1Rs
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-675617e81f9so1741807d50.3
        for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 17:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792886928; x=1793491728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OSC4ftnTo6YGV1dHbcFRy9QyJa8EnMoA6aGGO4fBdTk=;
        b=a4kyn1RsoXyAe+BMj98OM2o6BnP3ig0CSWjT1CR8Plhkum6F65npCHTANcuDOfFv+w
         mo9x5EodTMZhJIf9XQLRWyfmzFjiZXJlnPax69on6IKwLEA2mkSxywTRCu5Jo3/kKklj
         J3N5stlQQ5sn2DhMc1mnDctZ8ND96MPj07F0WPm7RoAVW4bGHDK/CP8Dnl3H2xueuilT
         UPekTtBsnRbz50O/LDPEAcRWIVCtdAAPaFL9qFt6jBrqP81n8wlJv1DTS93ZwKvr1Fua
         1L7Pt0ekrQ4dkiyLndXoJExf1vtytp/I3ifG3UuVXJ7kaDXfmK0FzjbinEucHGHlG/dy
         Xeyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792886928; x=1793491728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OSC4ftnTo6YGV1dHbcFRy9QyJa8EnMoA6aGGO4fBdTk=;
        b=M04W7nfc0MmZ6QHsZjqZzcB7d3FCIAAP9+uoPl72EIRSYILdofUlo9V5zZuloNL4Pa
         fNezcdzkg5kRqAzrI6yTfx+Qnp7Buzm22wFQcbN7BybK+dprhiroRBWA2VaPV2TrBZKx
         WgLHzz1Vg8PtHrQqCkz5zPWopkAAvktttxGGW6tQoszCdN38dnsttZqBPo3wXRM+tojS
         MqCYA7QvuO8dXk5ub6jj+Cbd0pYERqRpCZ+fuOClj3VnCmIGCbupzI6C77W6Hqw79mOt
         YY4/VFsSivfUAHyu5r1Vx9GmvowmQTB7ZeOvrGqEja+sfL+AtjjTxAIQQ1qv6IPbHtT/
         BXaw==
X-Gm-Message-State: AFq9FYJgbpYcbt6KXKcbjqeykPSB65Kpj/PhWDOMd3rpTOskiQ+JS62H
	U3XtmMG6Gy+LZ5wxNKsONwsM5wX7DBlsMgZbaU7lN2CWOkiYPI9mnqMYrbENkg==
X-Gm-Gg: AYBFou3oKQcTUGm2UpgjOEYg4aNdqIpKjmdrocDI6mLdXXb9xqZWbKDWCwziT7nKwU/
	QQGpX0cFDVdaPK/slUSvnp3HsVXIoFl4ZvRJ5LG6D5BJ4E1wjwKdLL4DMBn+VCgCkZbwhgQe8By
	eV0vF/qWS3+x9z8un0hte6g1RtWTfJESj5gh3DeZlowPXLZMv4Pf13OlBc5ifUDrDMoSX2Q1Et2
	F5s5vkO2WyEMhJq0hWzBqipH1R5lhL2Eb20cJvdVtDft3iqYKVddKzHqUqsNkWhCzutX8MBcNqJ
	3tV8o8qKdBxb+Zf3Al0pnuRkmWQsRCSeSXb5Po1pLBFrhHrndi7veXsNyiw64Y70LaIjZ5JnonD
	A8tlJ6Q8Kanc5vXR45Lm/ufafGs7tKttvrXFDJULpk7FCBBRTzotSHf20GJOsVjBuqsUkAtohc1
	8bXsCd6SzKX1uNpjD+8jAlGLC6GbDEyvyL2g8OlVKLrHKNKq6nGz8hNwMj7b8qqkqMQIT3PIoSk
	cgoqyN48jqfVFqyI1LqTqmEk9mcRD7wNApy3y+h53M+TbN7euEd7qY=
X-Received: by 2002:a05:690e:4851:b0:679:9b73:bf9e with SMTP id 956f58d0204a3-67a453f9553mr2071640d50.57.1792886927621;
        Sat, 24 Oct 2026 17:08:47 -0700 (PDT)
Received: from gmail.com ([2a03:2880:1fff:49::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a45ff8d6dsm1551707d50.1.2026.10.24.17.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 17:08:47 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kbusch@kernel.org,
	Nikita Vetoshkin <nekto0n@meta.com>
Subject: [PATCH 5/5] PCI/sysfs: Use user config accessors for serial_number
Date: Sat, 24 Oct 2026 17:08:33 -0700
Message-ID: <20261025000836.58294-6-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025000836.58294-1-thepacketgeek@gmail.com>
References: <20261025000836.58294-1-thepacketgeek@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

serial_number_show() reads the device serial number with pci_get_dsn(),
which uses the kernel config accessors which don't check
block_cfg_access, so a read that races with a reset goes to the device
mid-reset and can fail with -EIO or report an all-ones serial number.

Do the capability walk and DSN reads with the user config accessors
instead, as the "config" attribute does, so each access waits for any
pci_cfg_access_lock() holder (e.g. pci_reset_function()) to finish.
Also wrap the reads in pci_config_pm_runtime_{get,put}() like the other
attributes that read config space.

A reset can still start between two accesses, but the next access just
waits for it to finish, and the DSN capability is unchanged by a reset.

Unlike pci_find_ext_capability(), the walk doesn't check dev->cfg_size
first. serial_number is only visible if pci_get_dsn() found the DSN
capability when the device was added, and cfg_size is final by then.

Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
Tested-by: Nikita Vetoshkin <nekto0n@meta.com>
---
 drivers/pci/pci-sysfs.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index a272f8583a8f..cbdd56b92d1a 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -696,10 +696,23 @@ static ssize_t serial_number_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
-	u64 dsn;
+	u32 dword;
+	u64 dsn = 0;
 	u8 bytes[8];
+	int pos;
+
+	pci_config_pm_runtime_get(pci_dev);
+	pos = PCI_FIND_NEXT_EXT_CAP(pci_user_read_config, 0,
+				    PCI_EXT_CAP_ID_DSN, NULL, pci_dev);
+	if (pos) {
+		pos += 4;
+		pci_user_read_config_dword(pci_dev, pos, &dword);
+		dsn = (u64)dword;
+		pci_user_read_config_dword(pci_dev, pos + 4, &dword);
+		dsn |= ((u64)dword) << 32;
+	}
+	pci_config_pm_runtime_put(pci_dev);
 
-	dsn = pci_get_dsn(pci_dev);
 	if (!dsn)
 		return -EIO;
 
-- 
2.53.0-Meta


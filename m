Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301645;
	b=rQt45gBCNVoRVe5nqofnrP9XDPXD1MiX1Se19WUTXmPDWqjWpbbKHjKPOxvKWKrLn1e6
	 JaJyhudUjie/FuItu2XiqqTRSCYn3rCZg3YOMZKvK1O+/OUiq9WTtRJwm9fat+zjnu1nH
	 0/BCsBqoJd52gkpU2CP/9kapQgqjbAONWwvPyhGjVODnS9D0uGZ3c4Yb+sVVs+aSSl7/Q
	 NZcaA2dPVbT+n4bj1ikj+nGqre8QKg3OoA3AUDSMrDJcppbfaS9WeTAp0dEpkJq+4dLVH
	 0KvnMl71tI53h27MKsOXX8IDkEk10zHd2qILtEBkqPYqaDB/EPl0oTIvwxC3JLPnNfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301645;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OTOeXd7mA5QqjS+6C2ZpxpznOieEWowecDQJlB5SCxE=;
	b=eyDG+0a3ob0ycDVwXlhMCGisbckNx5714IAZVag8dftgfuQLoFDo6posM8Sm0aSywzcC
	 iPiLkWwhqIF/2Rwz6qh5zyjjyuKikynUl+Zqty9T/nnJu+keg/uLVR1euZcBdZOJBTNYB
	 58esyi253p4Y8U+m4FR+n41YVlvQ0RTmJvVj7QNB7UOEAx/mNu2J3DU+gajgIB7IS+LU1
	 /oUAcBdceKjdu4ORLfKY27GYBnixQ8FJAzzfXRLA6otuSJO7dLp/lo418cYNzb0F8cPDa
	 9fDR3VzdQzgMnALjIxFjbJcv8m8LEZs2w/26AfeBHpZir0YXnoKpMXay3foHLY0gO6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MDWZIvNJ;
	arc=none smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A2B60A2605
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 19:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01A2B60A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MDWZIvNJ
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-679e86015e2so1258943d50.1
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 12:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793301644; x=1793906444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OTOeXd7mA5QqjS+6C2ZpxpznOieEWowecDQJlB5SCxE=;
        b=MDWZIvNJXJWfGggaqa/rEVWLESYuOYbys+QrQUN+FoJraiHlv/rY3p4v6OS5Lz3SI4
         v6gfHBwX2bPLwBwh7s16+VXCYDhyi+c+Gl5iWhtqXDLrAG6s3sY70j1iFCrjQosGL7Ih
         6CQlzkYLaxeD3l9hcUkSp3+BQEFfNMUIN7oCspPNwmB8sm4VKD+FIFH7WuEkazfBl1Aw
         rH0vRBihDifw18jfKYgh31PYfFSG9PFzUeqAN00d5nL0iKOOQyIL1q+Nqoj1s9h2JNbv
         RI1ovIG5lkEH8PJ8ei7PQEy68PCP1LOVRhv1ExlMaOnYgCZDWnXZ9p8qVAuSj+cMxcif
         fByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793301644; x=1793906444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OTOeXd7mA5QqjS+6C2ZpxpznOieEWowecDQJlB5SCxE=;
        b=wIqJOtiN/A60XB8F5n/bPSnAHX6LU5ZUSRPs3aomHz5707oBzv9UW3NUg5K4xZaJ4m
         mRH5hBgpWPWhibb0FWuk6ddjpbtdKBhBnIliO23yCoG82ilOeLu+lhO9yGhv7L0bK6f4
         P/QoAEOMku72RvkRnlEK77jrkOquGYXQGulcaIDBDDmqagXOCVACFv7JCZU4oDg0cHf3
         Kd0PGMeDg8XI8BmFJFrUVw1Uu0aaSE/Fm0l9UHsa3Bw4VVQnnSsW2sKPz4q5QlCh3yRh
         Njz21yDn9Mkzx9r3Yb2XXzrRcRRCbYMmXIwzXfbccuRgdCbBEQ1MdOpZ48+2VQeoqdgC
         +AKA==
X-Gm-Message-State: AFq9FYJHhCpr6XU8Syxj6jt6Mj67Wq2au2GFIuC4IMK6w31oAWL/tg2k
	rMWOqgOxg2SJJA3Ob2t4C564txprXMg/pOJ1PinFYOzd9gOLNb9TG/mU
X-Gm-Gg: AYBFou3CYlfjj2jeRTeHEwidf6943rZdlXqQvub4MF/LT5uQoaQOD9IQu21XHJoLBix
	C1KuikcJdVyf5apjRKMo9QfjGZ8R3gKnWBpvmA8pYbcynx0P/Hoot9tw4N0BnkAQ91a5EK4r6cD
	1VQsDAGGp8Ws77e4UtH1SYe4+2o3BRzqBd0FYED4jDRwmJtFi6unL8EwztZL0due4vc6M3wK59h
	FnIyb7eQxs4x9tnPM9pKFBkkt5i5tuNd1b480IWdvYkSsQd5ns9Uco7aaf6LZYNaZmY1sQstMB/
	VjrWBQJBNdgpH9NKc5JDQTHxR2D0awzjZcr4t4dgdugX+VCrpi2su8J0/fHoaLpB5XN7CVhNLSy
	KLFcJqXz6ddS1yCKa+HTaHVU+rJA9YeHGuVl0zjrh9RE4kPhSp9krXxFI65MhsKiQ+HwwUrTQY7
	zjVZjn6IsKuUsXDWmPvdL9cAhFog7fwV2vJkDQ1kjnz5xKFjlSEmfKrG7QscO/LIaLYbRdBY0Jq
	Z0Jn5V66xRKU2sG8U8ogOXlPkaiCZF5zsTOPoDdOu8k91Fi1B6kMLidt2I1IZlU0vxOD5Ofnw3q
	bzvjQinNRehmZesJBx59jM1YxJu1
X-Received: by 2002:a05:690e:400b:b0:679:b274:8998 with SMTP id 956f58d0204a3-67a8d6366e5mr2701592d50.47.1793301644142;
        Thu, 29 Oct 2026 12:20:44 -0700 (PDT)
Received: from gmail.com ([2a03:2880:1fff:45::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67ba3a15d42sm151406d50.14.2026.10.29.12.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 12:20:43 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kbusch@kernel.org,
	Alex Williamson <alex@shazbot.org>,
	kvm@vger.kernel.org,
	Nikita Vetoshkin <nikita.vetoshkin@gmail.com>
Subject: [PATCH v2 5/5] PCI/sysfs: Use user config accessors for serial_number
Date: Thu, 29 Oct 2026 12:20:29 -0700
Message-ID: <20261029192032.1325629-6-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029192032.1325629-1-thepacketgeek@gmail.com>
References: <20261029192032.1325629-1-thepacketgeek@gmail.com>
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

Add a check that both DSN reads are successful, unlike pci_get_dsn(),
and fail with -EIO instead of reporting an all-ones serial number if
the device is disconnected between the capability walk and the reads.

Unlike pci_find_ext_capability(), the walk doesn't check dev->cfg_size
first. serial_number is only visible if pci_get_dsn() found the DSN
capability when the device was added, and cfg_size is final by then.

Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
Tested-by: Nikita Vetoshkin <nikita.vetoshkin@gmail.com>
---
 drivers/pci/pci-sysfs.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index a272f8583a8f..c2a5f53affc1 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -696,14 +696,25 @@ static ssize_t serial_number_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
-	u64 dsn;
+	u32 lo = 0, hi = 0;
 	u8 bytes[8];
+	int pos, ret = -EIO;
 
-	dsn = pci_get_dsn(pci_dev);
-	if (!dsn)
+	pci_config_pm_runtime_get(pci_dev);
+	pos = PCI_FIND_NEXT_EXT_CAP(pci_user_read_config, 0,
+				    PCI_EXT_CAP_ID_DSN, NULL, pci_dev);
+	if (pos) {
+		ret = pci_user_read_config_dword(pci_dev, pos + 4, &lo);
+		if (!ret)
+			ret = pci_user_read_config_dword(pci_dev, pos + 8,
+							 &hi);
+	}
+	pci_config_pm_runtime_put(pci_dev);
+
+	if (ret || !(lo | hi))
 		return -EIO;
 
-	put_unaligned_be64(dsn, bytes);
+	put_unaligned_be64(((u64)hi << 32) | lo, bytes);
 	return sysfs_emit(buf, "%8phD\n", bytes);
 }
 static DEVICE_ATTR_ADMIN_RO(serial_number);
-- 
2.53.0-Meta


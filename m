Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794865166;
	b=FpVO09qeHqKJIFiuvgCCi+COtCHFY4LfyqpyyOZHo1kJ8/oLss3uWCmhm9By3j+wZ+S1
	 3A3V4/T9KBai8mdldSwqNHIayl43YR48qUREAKeFdPIAsVMjGmyoIMUA0Hi4Ce9EaPz5f
	 6Kqzwsg8Pswi3c8IQOVejqEf6tvcvHNOhimXtEewmmrUFMtU/KxUqB7aYLrOWAI+AjhvK
	 LpQqL9HR26NEOpLNxXXaOnKsOFdnOVcrjp+Ifg1R+8AsIaoXtnfaWNVnAgLRVUiqthtZx
	 q5CEoje0NI/6aqa6bmrW+e4xf7nvuFvARFK1Np4RNIDqeamJt9NNyeYBUEjcHCioEzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794865166;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:Cc:
	 Content-Language:Content-Type:Content-Transfer-Encoding;
	bh=opnkhLUC6ThL0jMd9CJlNSJPx4niwGCT/r4/32rpuBs=;
	b=gL8+BuCXyVZLu2pQA/1jjSKVUso8bjTvBYO8YITFXYTa0YbXNm4qVfWeKvn9GKeunmJI
	 wrk7rEfqrfYypnqWBq1Os8zWZeWOGOo32qrLZPKz6NOQDx+1ztiYW8r3SYBQn1zrpdBOD
	 zHvEfbUDAKXYB11c9LGRf04XgVzm9MsajB28HqH4Ucp379AeY/cUFpui1deY0JgEd1y41
	 KX0w+YjXBfPMGUjLb7WEetbQWE1EhdIRx/0diFtF/gLQ0XHL7/+I5YIzEsK34orY8l0vE
	 nuNO0a8e1aUyddbH2MJZ/bN12QiU2j3vEQ7YCeD3Q4VYF6pQ7pKUYFJtmTJj0QZIqwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0sJwunB6;
	arc=none smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A16606A32C
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 21:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1A16606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0sJwunB6
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-67990a45e02so4203298d50.3
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 13:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794865165; x=1795469965; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:content-language:cc:to
         :subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=opnkhLUC6ThL0jMd9CJlNSJPx4niwGCT/r4/32rpuBs=;
        b=0sJwunB67mZVBzvystQxzO+I805REdp58OlLmomLRxAPJqq7ZDStUzlEv87kHZZCtW
         qtbDLZQLHtYWFlvakUOSdEGVHnHjZugOr5i2wSZKuoV6SmrM/p7kh9QLDxFWS6skrtG+
         A4nTG4GabTURfQIQbl2rTZv1ZrGobHuOgDoULll0s6bHuttXEbIcu5ATiuD1K0lDwKtM
         3go0Paw1WysOBnN8F1QwsVpMzzsapPlNBgOJM0UEM3283e0PEle9juiEo0laHgaoQmgx
         S+gcQhHIs4MwwMC53ku2Xqo7Zu/XoId1WMcMcrJiu/8XIDNLGyujwW5VW62C506r8RW3
         sIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794865165; x=1795469965;
        h=content-transfer-encoding:content-type:content-language:cc:to
         :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=opnkhLUC6ThL0jMd9CJlNSJPx4niwGCT/r4/32rpuBs=;
        b=aV3jYowr/ivSo0nseAoCsmpko4LPxhRQLr9VWQvSgXdcwiUJ8584W1hscRHp17SnXL
         srMHLYFvFtOTZhTZqhKg85i7isauPfUxpfcdLQ/qXLgdS3dsKG3NoixvvFh5vQzRwKCt
         v1+SO2Kh/suxT/QScg9gJG6ubLv/UTOlWKqLvvF8EsZJc6XUn1nR4GYruw3dkfFXPLA+
         ICntchvWevghExjqGSiXLbIQ2/EisSNPAsBc42KQawtKOTFN43Bpmalqirxoa3OYO2d0
         FKWusV1mZGyWqJ8MFoP/QLhCSEmeBtVwmVCDFTU4f6oyZIGAFKv7tIkvLMfMYQMrgGPC
         Y1Gg==
X-Forwarded-Encrypted: i=1; AL+hErHl/WDjp1i2YbMrEEZQQi9+FIQ8oOlpG1eT5jglg7/IRw+E/Y2uXngB4Uof06e6Ti5Gw1SX02eU5Sk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/EVFkoh5KW3Q4uMZRUGhrzGeaYhf5uQY4nqvpTtPQ9fjsPjDMR
	v4JrmA991zskBdJFWpYvDTRBNkNLM0Dct/c37e8q8N2SB71WZDmcbgcaXNOLpw==
X-Gm-Gg: AZFdTZfWi1k+HJ5dEXLLpUyuP8OcZHTr0gaPrJgYKuuzgLfpnPHRy9Pvr6ShMwz8VO7
	KYYdmASn0g/4TNEoYtfAbAmFcuNchADCHZLfvbIwKMLfTeKKBIm0jQ0OSqXphu8yLcX6+YFTOr2
	0d7s4VxWsMkNCg+LVRO7WrnCduGA2gUua0eHVIpVB2BAinfl8kyAIqVtEjShEaB28P15Q1Vxy4x
	GU6h1Qd8YREbstmCTWPppLIVvz/fmrjoAjyJdsH+LD7KrDZjY93+41tkAkKSeyZuanOUgkw20Za
	1ITqvgeY5kQrl5OOxjOb8mI/ct2A3l5PWUiPZjufFsppfN2qkEkU3n4F7W3Q4vCggwrfCZjzL38
	QJEHPNcG2WoSmHKKYb/PV3zU5u+BH/9mpFd1Em0mmyxqbSj+6vVVC7s+TlaltWGbse9IyinWWtj
	0EhpHtHntgbv+8ZrKMik9/t/DbREtBJ2XE4DQEBnhCbIKn+w6wiLZaxB5//x72aItYECRhDK1Tb
	Use9OG08OnPu0ZHGUv+/49JOREFWM5NlQhQeYdhd6oPLQDWciH+lggEmPTK/swQ24uSCnxapQpu
	w6YSF1y0feBB2lLtubU1EI7DxXGNXJO6kDjZQULBdUosfg6zE7snDvjLclKyhOKrz4H2GL2ij3P
	CRaLSA583B0ckMZCV4fsmFDBgZsPpqr/QRhmVu9m3b0uHCBQzxwdsZ/U3EfRjsK+YSc1YK8FvNy
	D1WZK5Bb03DMrzNhA6eWCjdP0VBvAkA3ZocTGNoVYq/YteQk922+jsLwlCcOnEtKsFmnX9kOSQG
	cZc3IR7qow=
X-Received: by 2002:a05:690e:1247:b0:67d:bedd:494e with SMTP id 956f58d0204a3-67dbedd5bf7mr1613692d50.0.1794865164830;
        Mon, 16 Nov 2026 13:39:24 -0800 (PST)
Received: from [192.168.207.4] (104-12-105-135.lightspeed.miamfl.sbcglobal.net. [104.12.105.135])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67d8a55b09esm10924904d50.6.2026.11.16.13.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 13:39:24 -0800 (PST)
Message-ID: <9ed2d8fb-fad5-44b3-82a2-0021edb405f4@gmail.com>
Date: Mon, 16 Nov 2026 16:39:23 -0500
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jason Perlow <jperlow@gmail.com>
Subject: [PATCH] PCI/portdrv: Do not advertise DPC on ports without an AER
 capability
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Darshit Shah <darnshah@amazon.de>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Commit 97ca178c899d ("PCI/DPC: Allow DPC on all Downstream Ports when OS
controls AER") makes get_port_device_capability() advertise the DPC
service on any port with a DPC capability when the host bridge owns AER.
It dropped the earlier per-port test for an AER capability.

dpc_probe() still returns -ENOTSUPP unless pcie_aer_is_native() is true
or pcie_ports=dpc-native is set, and pcie_aer_is_native() is never true
for a port without an AER capability.  Such ports now get a DPC service
device that can never bind, and every boot logs an error for each of
them.  For example, on a MacBookPro16,1 the Cannon Lake PCH root ports
have DPC but no AER capability:

   dpc 0000:00:1b.0:pcie008: probe with driver dpc failed with error -524
   dpc 0000:00:1c.0:pcie008: probe with driver dpc failed with error -524

Advertise the DPC service under the same condition dpc_probe() uses, so
a port without an AER capability no longer gets a DPC service device.
pcie_ports=dpc-native still enables DPC regardless of AER.

Tested on two MacBookPro16,1 with v7.3.4 and v7.4-rc3 based kernels
carrying an equivalent change (testing dev->aer_cap): the ports no longer
get a DPC service device and the errors are gone.  The patch as posted
builds portdrv.o with CONFIG_PCIEAER=y and with CONFIG_PCIEAER=n.

Fixes: 97ca178c899d ("PCI/DPC: Allow DPC on all Downstream Ports when OS 
controls AER")
Cc: stable@vger.kernel.org # v7.3+
Signed-off-by: Jason Perlow <jperlow@gmail.com>
---
  drivers/pci/pcie/portdrv.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 32fc623dd4..e7358e164e 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -264,7 +264,7 @@ static int get_port_device_capability(struct pci_dev 
*dev)
  	 */
  	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
  	    pci_aer_available() &&
-	    (pcie_ports_dpc_native || host->native_aer))
+	    (pcie_ports_dpc_native || pcie_aer_is_native(dev)))
  		services |= PCIE_PORT_SERVICE_DPC;
   	/* Enable bandwidth control if more than one speed is supported. */
-- 
2.56.0


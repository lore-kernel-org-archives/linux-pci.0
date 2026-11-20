Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795173099;
	b=UHsTdlIMMShv3aGiFc75DWomQvwaQKl18ihf19b5WcIvVzTdddiUUXnr3o2kHqNJrFU4
	 zDoOGaIER+Zz/3+jOQOzeQSWJXtc0ca0hZTqtQYc8rpin9i3RDxGHf7xRlY7Nmk+/87fL
	 kXAOEU5bwhw2e87a3nTIM9kofNP+ODu/GPlN4IUNXaZNGrdQFC5jQIOANgBguTe+mZlTW
	 Jqy+Nte/8a/Vxfc3eBRE4MAdPgBWgbf95nYrYLmw5QuuKSc91Oa/Ukt3J42SW06ujcWoA
	 X1GpzrdPULVhhGziHl5FleGEwoF3FC5KB5qODPn1nLYedAPxgdqAg0zJnI6yfkqJ7iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173099;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=jCk7TrXv9jUrk4Gfl+UVBBzdL7B0+zwnyGk+aBsGGKk=;
	b=zc3XDmWwJGKkmmMxfxgFGBOjbot8C+5yl/26gj79SFGG65Fi6pPLj+3J2mUhsKOxB0LC
	 9PPqZPXL3FyGZjudI3aBisGwDcNLw9AY7eQRW8cbHmFZV9RroneJDGSqu1OGDUL01nOwH
	 C2IvIiA3rwN2Vfg0agkTFKo0SuCbS4hdOhdU5iM0evzm5lKnQjCfOeRrB9EXET2Aocx5k
	 aIk1hoD7IihmXYjb07yqMXzBYzOhug6oLX+WrJYsy72ZblFTtuLe4AdVDKaF+Cj8Se5Ga
	 /z7Xg7U28wrjoKWITIat9LhtpljRi5CoVe2jh8BJh8+DbrBUCwEgMc34lOB93CrVT3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=fue1tzI4;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D74560A381B
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 11:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D74560A381B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=fue1tzI4
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4a2f4ca0dcfso382210f8f.1
        for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 03:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795173096; x=1795777896; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jCk7TrXv9jUrk4Gfl+UVBBzdL7B0+zwnyGk+aBsGGKk=;
        b=fue1tzI4/kuCB2cGdMm5c80OylZihvMeq+oe9Y4WPgypSow1qTUVBzRoxv1prpN30F
         Q/3gltySmOq6YIEkB7r7VsdZK8loZA/g0CWgJ8cF7cFXwv4j4N8UDR79MAXRP9GxSf9c
         9/1qG/hOx6XKvqTKHBuhoOmEq2etQ5KBrhAqBEB3hGd+CiLSOleZVJ/6r5X/NGJKkwhn
         DuD6vEmhVbRzQsq3oK+SJv4R2lsxHVsDmyV99TwwOtigbfgMAqFI2zCh1G7VMiTEeyCM
         A/W+GYlkY3KgGUskp3Uc76dJTzVfzQJ7c9XHadcjBLNV65KkhHB2v/C+7qe1no4+Z4FI
         c/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795173096; x=1795777896;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jCk7TrXv9jUrk4Gfl+UVBBzdL7B0+zwnyGk+aBsGGKk=;
        b=gDx1qGzKKC3+Mrk9vcFD3r3mWZ/NIE6MH9LJe2KkjSkziJFn+mk4GMii4asdO6fvpw
         y3vjEurzpud8SfO82b837U+9ivLwAPQuw84g8Apwh4Ej0sFoIfq2bAVCLccSa1Solak2
         mKBZzLR5C4IkfSeqLsoTXNSOgC3ZArZ91D5/v0yeAmtcni+tnN+RvN1k+/UW7JMZBd2C
         jWoJeOuiLpXRBAGUr7L1Fsi9JCC2swTexoGW1w0XBXlFKytLh1iAY8eWurn4CxpGXyrZ
         gL31eOyuGPAl6Vb90I676a7hS4Xxv9uvlEkGnAVfCOdykNpbxAcvzEmIdrYyhODymLSm
         SKxw==
X-Forwarded-Encrypted: i=1; AL+hErFMeh2fWhdQsAo6QoiRec92lW66HQSYbTQym0GON1OSOv9SZPqXxWiGOskHVA2/NnEIK0HQ7nYIifA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+grzLQ1Q3tgTgpqv5TKLZWXPj/qRtvNgAycxZRq1GEL1QD3dHV
	rRcILddE6sIFiCm0bKCfU30wFoZvvdDDXk2ZnMUOFHzatP5P9sOrUoY95SKdPdYc5lL3YGsDGsx
	d9dQ3
X-Gm-Gg: AYBFou31E5RVtvMa4+jyv9deR7A7FwKWB/F8rNig5P1uVevWc9/N5OAt1+MUwj1wUna
	a9Wj3Ao9R/ouQVZrDBeS4+Oc4fTW11x9E2070k7KKYXiR3O63nqwycI8601FQGGHiSYqbAhROYS
	6cCr6ebv9UbW8OdJ97XPNoEyZSFea1a9qYYbgLJcWsTeMx9vjYyme2WZoawSkqmoafqHy6Qu21R
	fJjNfwi6rfMafpGzNXhMN9j3tuWIMG/u+cTbXMNKU52R9RGD7h8AObQPQV3RTbMdtiN9aUHU4xi
	PPaUIC1KMQ6m4G/1rZDiZTRluF32sH+jMClAnmD+uCq4oxujiqFRZVsbBOFChjz1P5lZhivnBSg
	IRTj/G18bXWk/uswrlw4McQlJwg/YR2Xqg5F9pCVxBSnUD9sAYSYHwUYIpSokIRN5P+oectyTph
	CrpHzScocw18tTjntNfHAh+CXknfEJxEb2SRMAqIxDTeRb2Issv+SJJOblg0vgfJjtgaDWsUK2t
	k2zVSRFhChcznJWeIIhTzyAMOgl2fPJPOkwVlzB/NLbCM/9YdhaVtqXlSzJrLfth7T2ttfJSRt5
	ttTho2G8wzso+JyIA1uZliI9jD9Tev7I0fuGR+57IE0kxOsR/FjjnK39IFqjXVQhwBhPpNmZkWt
	I92CABSyV9mjAwXvg
X-Received: by 2002:a05:600c:4f0f:b0:4bb:87f4:3674 with SMTP id 5b1f17b1804b1-4bb8880ef40mr71990655e9.15.1795173095850;
        Fri, 20 Nov 2026 03:11:35 -0800 (PST)
Received: from localhost (p200300f65f19a904be03815e1634e776.dip0.t-ipconnect.de. [2003:f6:5f19:a904:be03:815e:1634:e776])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb88f6b6a6sm84111685e9.5.2026.11.20.03.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:11:34 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Williamson <alex@shazbot.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 02/10] PCI: Allow untainted driver_override for PCI stub drivers
Date: Fri, 20 Nov 2026 12:11:03 +0100
Message-ID:  <875df446719648081cae884073d8d50086dc16f6.1795171088.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
References: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1829; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=lkF1eBjn9Y6UWJ3MiU6AZAk2Feckz7JHeHwAlqjCoHY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBrACrNZ1Jq9e11x52ErCQ+6JFtg5FGHMcI11UmD ohojlAGYUGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCawAqzQAKCRCPgPtYfRL+ Tv1kCACjd7tsoIEr6ldwOmoosH+QGEkqsyAdpJzA5qZyGN0aK6aERGG6FPCPWLMgFw1iFWv+V/D 5G5W82HhE7CI05mFtFFu6qjsX7UX084ojo7be1ltxKmtoR3g+Z6y1jd+2UOhpnOxpQKo+2Zxj91 /1rDKdrumXp0bQ8SlubEx5id/xUB0dzTpLtEZn4si5Zap3ykIHnvg9zdB//qMX17ZJttiNNT7AG Kb+2krUQ5YBiOANxnB/IRNxE2r3zhhktoqb7iXKpCvQ5LeIh6e27DR7t8GsRJfFp+c2GMBYGnWc AEWWSmN5Qte4pO5Af7/wyoeXTKIvvXcOd3myENaKvjIb5E/i
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

From: Alex Williamson <alex@shazbot.org>

As the name suggests, the pci-stub driver is only a stub, it performs
no hardware access and is typically used only to prevent other drivers
from binding to the device.

Similarly, pci-pf-stub only interacts with devices through the SR-IOV
capability, and may be used to create VFs on any PF that otherwise does
not require a PF driver.

Both of these are often used with driver_override, as this is our
standard, non-racy mechanism for associating a driver to a device.
With the introduction of support_driver_override in driver core, this
use case needs to be explicitly flagged as safe or else the bind will
be denied or taint the kernel.  Declare these drivers as safe for use
with driver_override.

Signed-off-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pci/pci-pf-stub.c | 1 +
 drivers/pci/pci-stub.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pci/pci-pf-stub.c b/drivers/pci/pci-pf-stub.c
index da4db4928907..328fb4a57092 100644
--- a/drivers/pci/pci-pf-stub.c
+++ b/drivers/pci/pci-pf-stub.c
@@ -36,6 +36,7 @@ static struct pci_driver pf_stub_driver = {
 	.id_table		= pci_pf_stub_whitelist,
 	.probe			= pci_pf_stub_probe,
 	.sriov_configure	= pci_sriov_configure_simple,
+	.driver.support_driver_override = true,
 };
 module_pci_driver(pf_stub_driver);
 
diff --git a/drivers/pci/pci-stub.c b/drivers/pci/pci-stub.c
index 9bc478df4e8f..acbd43c17adc 100644
--- a/drivers/pci/pci-stub.c
+++ b/drivers/pci/pci-stub.c
@@ -37,6 +37,7 @@ static struct pci_driver stub_driver = {
 	.id_table	= NULL,	/* only dynamic id's */
 	.probe		= pci_stub_probe,
 	.driver_managed_dma = true,
+	.driver.support_driver_override = true,
 };
 
 static int __init pci_stub_init(void)
-- 
2.56.0.rc1


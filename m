Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CEC34EF00
	for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771599896; cv=none; b=K4/TnVrFeaCvn3bEGQN/InD5yMq6jUMEgrgZ2W386RSFa3LZ30BNTHxFtpjxavcafH5btHJ7K0MIEC61FRwrspttdHMDjSC0NQb2B2Zygoyi6QGobAb9swwnWG7A4IfDqRRMPDyS5zm6wvWbqaCZwI04xH16qztD3Y2K8+6l97M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771599896; c=relaxed/simple;
	bh=xJCGSZr6hNfy2o1VTKZssAjAq6hV+BsznAwWlIlxuGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WvwcnpxJtD5B23mJOyPzB/Yj5mpUd27u+F7eBIoN4MmuxkWtzuNdhvEcPLjJom00/IkIQq/u6DYD8QphshtbHDnZjEuqqrEehe8pRcon9ehlUEfdWOUkwceJta19qos2meOQzFMecwJGN0NJwqBvOOamlV6OFp9kR8vdF081/zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hNPgyRpj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hNPgyRpj"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4807068eacbso17771055e9.2
        for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 07:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771599892; x=1772204692; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3M7D3/IWCY77zVq+OSkyrB/ybXLf5mjVJRVSBa3XrmE=;
        b=hNPgyRpj3+05Jw1n95GFcBjxBIEgz5bKcV+McsaCqUhG6lLrNwhQer8d8VoBwgvcwM
         Bapff6+EVOuAnl6iHpYfhHOQsNrYwgWty5Z6jB99pg0p0k4kpAc92qLTp4pbOsFcwR5g
         UHBcUYCtOGzVtKxGFuRWs0WgnQfJHup9erLug1K9CieWjIWGgt+UveLZOYy7/er0f7wf
         SI+wnMawD6ts/nvnj+rK04QX4LV6r71FZAN50yQbD7Dlp6PegeI93W3ePh6Bb2KyMkKv
         4ucR+njYN16wY6vqD32EyXz4cNWI1+80rnQ85PngHm7WACVl9SjxLpBGH8fv2mOI9LlC
         W9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771599892; x=1772204692;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3M7D3/IWCY77zVq+OSkyrB/ybXLf5mjVJRVSBa3XrmE=;
        b=AE+ZbAJ6VqR9DvaYAQ+KLhnfgOo7LqrkIoaYwIq7cMAvdezgDvE1Sm7SQAyfqVZubU
         5cEs2tQiSxyhhk5aX4lIJOfb2xHH2ByKbMsotjSdbh4gbyfgE8t1c4sEGFO3aP7ai/3V
         EO5a2o0Jxh4no9m5SfS5HJFD9czm+rqZOr8nHKXDBFrTHi9WJMuZtMMs8SltIz85HTsh
         l7pWwm82lg46eiWqBvfvzVtlOcu8rCMNIcKY0Yms3u84XFNOcCo3zND2fUcDHMRw3/B8
         fYDbJ/zfKL6dN6LXCv6ltPCirV3HtuhNjb2RT1Lbc5oiIC+8FJ9Rd4lH9pDj2/ZR6RXG
         blZw==
X-Forwarded-Encrypted: i=1; AJvYcCWpIBrTqiuzty3RsmVhgVoZeoipw2oILzK/9uI6Ro8I/e/EbyUINprDhT9D6iAaL1212BSjUz73a4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPHMI3GW+tzCV2Kdgzhur6w5rtCtS/k/PIGrdmi12R8cZ8oWQU
	gN0gbAWsEFNMThstUv4whiuqemyIF+aBPdrP5CsUgR7y+MMeHmEKDb88xZ9NWiizZM0=
X-Gm-Gg: AZuq6aK29DbxHZhFuBqfpEhLttaTI0Fi2zaehsSLdMEL1srO2VbRykbwy5nJZfaJjUT
	rCTHQoMAiUtzSbPx79uqMZ7XUXCdkXZWVIlgJOMYP9RTWx5yQ8ij/QIErEuUd6VT6Y4jJlfNMqL
	cL34q7y4JvGfqD7/WGDw/2gQiWNCZdAGWxMdPe+opnSRhpXuKvm28/OZBXjFHejv8gXbqdej557
	E8MDl/bYwzRGRnGsfm/f7cp22nTCwrFmJhP//f82+8F104dux5vKpS2EjlhwiD72OMRIBDtcohP
	TBlbkXYd6qV5DDzF7okeleA8BqZCbvYczY37vB8D+49E1Z2BM8xs1GUy+oeWNESdxI2ijJj2mdv
	awr3Gni4wyRnbLjUv7Qx+KOUypjeamNUdE04syMez/o6dpqXTYta9QzOI6/FEeDFH3m4QYRZONj
	dXgDGNzIo4FZ2sHS5tIc+SJlewsHcUlvl7oNVIF0R3LP7r
X-Received: by 2002:a05:600c:871b:b0:483:7783:5382 with SMTP id 5b1f17b1804b1-48398ae5e18mr152435765e9.27.1771599892357;
        Fri, 20 Feb 2026 07:04:52 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31c56d8sm122064505e9.8.2026.02.20.07.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 07:04:51 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 20 Feb 2026 16:04:43 +0100
Subject: [PATCH v5 4/9] pci: pwrctrl: generic: support for the
 UPD720201/UPD720202 USB 3.0 xHCI Host Controller
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-topic-sm8650-ayaneo-pocket-s2-base-v5-4-1ad79caa1efa@linaro.org>
References: <20260220-topic-sm8650-ayaneo-pocket-s2-base-v5-0-1ad79caa1efa@linaro.org>
In-Reply-To: <20260220-topic-sm8650-ayaneo-pocket-s2-base-v5-0-1ad79caa1efa@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=903;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=xJCGSZr6hNfy2o1VTKZssAjAq6hV+BsznAwWlIlxuGI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpmHgMmJnNP2UaHm8nHYbJM/bBXMFDCVDHeA692oFT
 nHGCmBmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaZh4DAAKCRB33NvayMhJ0VqkD/
 46dy1L1HpkaVrmje7dWcxQPqjm++pN0TNk3nqAaJgv+Qv4GlwOnO/WYO5OCkCnitKFEs41reRqrDXN
 bbVaH0N8Ar+c6mSijlW8JV8QgFVWZ5vmZ2gY4Nxv3rIBjzupIvFaMKEEKNJxJ8eY3ZsRUQ466JqGEw
 v5xu3n5oL0XcFMZExX5AYr8dcvtJ3irg/T7qaaS6g301pBP+IAJHsy7UqHvUMD6lxt3VeLtcajsBvc
 aPX89coqrNyOuRnhNl+TJPb6v9/WEWniQpwfvkva3X6bMCVWkB6ea6XwbhDe6Og/KBRPL5aLRb5skj
 PfEP0G34YOVW9oMPUwy9UbHZD/SXW5Nk2gZ7bUio1rlaxePrMv9E+y6YgiGfXhPdwShmxkdjqnEMOw
 eSGaoKc64NUjNkJ/+sHP0kk7xyPfh+iNlTZQ35FZE6Nv1QX/6JVaUifAnJ/cLBqJp6XyiNK50Ri4pn
 6ymuewV0659YD0y+JZ8qp+8TtdETAWe8mKqeDJ+6/tgqeEE2RmNJ2CJCOmPzNKju0gcCh6aKXoz1tZ
 8sFF8+DFQPFvZbhfsOF/85IEWp1RIHlPMV/BCAYALdWOR3X28BDbqKdI/CgKb8GG2/DqHwCDcZluJg
 RsRDt1BbsHlxJ8qUicbTD8JBVspS4V2oaXywk73WAQTkThbCVX1sxOqhViMA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Enable the generic pwrctrl driver to control the power of the
PCIe UPD720201/UPD720202 USB 3.0 xHCI Host Controller.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pci/pwrctrl/generic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pwrctrl/generic.c b/drivers/pci/pwrctrl/generic.c
index 8e6f2fd5bcaf..a48896118d5e 100644
--- a/drivers/pci/pwrctrl/generic.c
+++ b/drivers/pci/pwrctrl/generic.c
@@ -121,6 +121,10 @@ static const struct of_device_id generic_pwrctrl_of_match[] = {
 	{
 		.compatible = "pciclass,0604",
 	},
+	/* Renesas UPD720201/UPD720202 USB 3.0 xHCI Host Controller */
+	{
+		.compatible = "pci1912,0014",
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, generic_pwrctrl_of_match);

-- 
2.34.1


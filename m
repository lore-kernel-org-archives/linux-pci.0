Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE473B0AE5
	for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2026 08:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773910519; cv=none; b=CR3e4VnHfn6GMksm6BNvpfbMgKo0OFNMsNMruKPmIVjBZc07pwUVtonvZY7oTnVe5+/nqzd1uMuaFI+2VNIGVROQu4/CLgu7PhTWTfSVcHlOF0ql8AKPwM/z5CZg8eQuSJCMj8clXousa8ZlqCGPcIoQlYJ5OJ5udV+Cpvd3mvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773910519; c=relaxed/simple;
	bh=5XxWigC5My4B3x24Szv6ks3z8EguLjBpSYctWIzjgW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jd5Pa/kHgomikVZG+nt2sfNphrlystSjAGw5xeavgVB3NDhIEaI1ZZgZGFrlD6nnh/Yn6amC+tyiJgXIAMz4tgXmmjCA7wCPDSkpMJFDwqa2XqO4oB6YYUy9zC0duG05Y/365OvlPOdD94PvnkE+AI0KBqrD1c0Sz0DWzaNmNPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZYo20634; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZYo20634"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43b4121c40aso417623f8f.0
        for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2026 01:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773910516; x=1774515316; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8swaaNWSl9RHsLGGBfu8B3B1mvGualJmPbpF6pl4oPU=;
        b=ZYo20634g1jYb89G2/6s6kncGg01GNoTEUhcFAeTMi209owQ+xqEsueeYh5hnXLuUg
         mT3uFkENCMjfxaCq8YKPo3JAADDBhrgtfC9r5jsITpgJgk/RjF/VCgKFuPhSgtYoyjn2
         qFlxPBGgcsJaPAUO87bU/COL7jMvT510jgiGXAKdZ6anoc8QNlGNppTwVNJr8gO+FEx4
         ESMcrgIep7lCK5nKV5uymTJmw+LJpwsmmBsZ2uJgVKXKKon+I8/a/Egiv7kzSZoHLpmX
         FQkRdNo8AP8ysi3+mZEE29wOmBxFCfvk4nTfqXb1Tn1l04KRuNJzyfkyGk8bq9k21UKQ
         v9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773910516; x=1774515316;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8swaaNWSl9RHsLGGBfu8B3B1mvGualJmPbpF6pl4oPU=;
        b=SvfXI3lN4ZDP+KHWkRrKn8Pl73GB4G//mv5ZPo/k6OYREEQ8h1Qk06Vkv8FMcnS5sT
         8mOZSQOep8cGRFhWKBIOFPRUfrboBzKBVdWlSO6d/PVXtZRntUSU9CEZZ26aD05X0APG
         Q7sd+TuMqZQ9Awgsv5Pv15oOC68P4RlXYdaQ2dVm9HLKlcsrtiLxs80r3eBtv/k6cPzd
         bWL7zk1SFG9ZE90DHhFJBpNmALgl4VXFJJ7M29Acj1Z2KKFGYva7D1wrhlCLVnVdiRl5
         nDLZDL2fx6TdwD5y3iXvQYAhgfxiujrKSJemITW0Y9ODiKS0kjJ882C9cCez/b6HDs9J
         Z+sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl1JnpKJ5FSXCjDvUMCSu0psbozW+rJ3PZeVe2u5HLvINgeuChEOisAQKrjulFkXGAFulkztKFuic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvWI60BYVtfVTGy1HUXQJbTBC7FZYQWQ2xoaetOis7fnner6E2
	QCGDZDAYLnAl5DnG+UaWGS9AiYkomqo7BUcP7CUmCq3FiDoWOxBM7hcOyE6C5GglOXc=
X-Gm-Gg: ATEYQzzoAmR8cpKRMstjoAkcgAh4cPTqAO9hSjFeSjNLd/lK/uQm/QkRJMANAc4AWG3
	/98uClVO9C725GCcwHhGyKpXMp6jJvTKP31E/ILhQQG3jU03THiQcFyrGHyiA1mJM7Y9J8xAxyQ
	Kwzz/J17VXGXg5+vdXrmXrmHoZmQaCS7Ep74rzEAjs4DEq9QV7/CUT5+ryPWzV049EDrbKVs+Sq
	DBLj940oSikeprvMEJS3T4HV634VsOnGSJqlCc26qu9MSieG1dFx9GAAegMf7TB2h1kr7QQHWvO
	73jeYIjFhlye3AT3xEPV6XOkZkwASiQK1xPV1E+D0nf4qVWX7CAjCBiiqJo0EAafJSfcpzt8x9e
	nzl73ix0VFF1UJdiX3odj5UULh+XD2MzJN8ZSsBPhqLf2vBqHQqPjau8Jpc2FHkfxMMScji33Na
	heeLyiwFIyKZVrl1jNbKADmtJLGIXIEpyutX7yKUgb/X4R
X-Received: by 2002:a5d:544f:0:b0:43b:5762:298f with SMTP id ffacd0b85a97d-43b57622a4fmr3176952f8f.36.1773910515711;
        Thu, 19 Mar 2026 01:55:15 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b518588a0sm23072267f8f.16.2026.03.19.01.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 01:55:15 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 19 Mar 2026 09:55:09 +0100
Subject: [PATCH v6 3/5] dt-bindings: arm: qcom: document the Ayaneo Pocket
 S2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-topic-sm8650-ayaneo-pocket-s2-base-v6-3-797bf96df771@linaro.org>
References: <20260319-topic-sm8650-ayaneo-pocket-s2-base-v6-0-797bf96df771@linaro.org>
In-Reply-To: <20260319-topic-sm8650-ayaneo-pocket-s2-base-v6-0-797bf96df771@linaro.org>
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
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=763;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=5XxWigC5My4B3x24Szv6ks3z8EguLjBpSYctWIzjgW8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpu7nuLW6CFzyeEaURq0TdwKGR7x2YQyIFu9wrygmk
 /Un4k+6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCabu57gAKCRB33NvayMhJ0WZVEA
 CE0nSlAt+Tnw+3tKQyLV56hWvjVI/qhzfRru75asl8IggHQfFCgtY6eCcoZOlFa/J3JFnJcAQ5aw7E
 SBB1lPVoUSGfZIKS9MDaCxdqozFEsQ3vyt3wabS2j+F8wSa9NBnY4bmfNwhnGbXUNBQYC7O9OQ/Lut
 MyQG4xe69TqFxzkxgg2RUNtwahV6YTDWMlQ7RyAOaag25QK7MGlb1siTpZmaAuo9BnJzOE6K+1BQFI
 v7tj5QUzA3Ec8h+p05oZ/nDgBja+jM5xNubVbruuz5zmx0POC3z6hm7dn2hqIxl6MNq+oZg6O05UWH
 QNKpwvtFkWfOetoMV3/580tykYz81PjJAYkKnBIpzuPWPAxqQHnI70Bv97AERG/ltEM0bKq4Mnnd0M
 ++terUMijoWU7iJSlkKmGFGqhFQ9Il/HBsdFUz06hh+hh/jbbfhBqT+gbx6SfsjTQEn4TKfXh+TzRY
 c7ketgyw6H+/VuFmSB5lj13LT9UGkVdmNQGQYdSzfbdTYd5+Q+Wu/te/wL4j5nsYiO66LskCg+2qQ9
 i68HG3ckbgJx0EF/FoDi7fUQThFQqEWqSxKlMMVTfpKlydxMDdfMm1gMlnuKV9OcO/yFEFmiS7UH1r
 7kjgTXBpwbIL935kyHICiKGkGCln8IGqkcspgT9aWxXq0eUo3dN8BlzK1+3A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document the Qualcomm SM8650 based Ayaneo Pocket S2 gaming console.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index d054a8f5632d..0a6312b15712 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1077,6 +1077,7 @@ properties:
 
       - items:
           - enum:
+              - ayaneo,pocket-s2
               - qcom,sm8650-hdk
               - qcom,sm8650-mtp
               - qcom,sm8650-qrd

-- 
2.34.1


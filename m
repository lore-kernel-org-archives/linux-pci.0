Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE914BD789
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 18:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789495820; cv=none; b=n6thIDAxaf6dqhY2C6NfphetK854cCGxU/vYtinnd3oC2v6377NTxt6xFtroRpcgbxZYvxZtYYzIocjKOn/jQiLTdqYMmHIgNpDYcWyEa0UvET19Vyaciw53zWP8BIYFFPQi0R9JV99VVEN1GtEWmKvT9NtiYD1viggzVXYsAic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789495820; c=relaxed/simple;
	bh=tdYpvWgSjy9pb8wMZZMf3uOm14EnHaub2C79rnVIBoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYHIHXm057yoDBhvO3XDdLuKc/rpaSc9ZpcNXOsqmXV4uApxAX/j9/zP93uvhZCG8gMQB7pTACvcCESE+acHpyGL0XfpYHfDTK/s+YdITYBBLw6MHTGM6Q0coPz5eSizWxu8uApRZhuDA97HAQ6jOeN3BlHh/WJ6KESKWES4pVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=Y5oG+aBt; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Y5oG+aBt"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939656ff6d9so6687685a.1
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 11:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789495816; x=1790100616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wVBxclk9QgEAlFYkz8nlTTQ0570gfN7zk+u3PBMIQfU=;
        b=Y5oG+aBtJVtpqqRxtOGL6wKcEKSG52hWTd5DotNLR/ER8j0U5csgxG0wWS7R6F9wXa
         P3+bOJO4Jjxnm030RsvRij+v0cTkJJl4J8DrJsDFMEp73LLiHUth0Bjdlv1N5xdgomco
         OwalUUhVD9vT/gQEf3Q3G94ZYNgwLgpk3JOaxonI9NyZ5ueV3yljQG+MXIAW7xkeanFS
         CVxZNkmzkqdYaBPfXi2KpbGkYDJl2jD0v6KYiYUXkVCdkvZAeNP/Iom+dSk4wjSs8nQI
         J9b3hxd2Pa5SSC8bxN1Az3zWfTXR+Zx0st2HJnvlnp+F5Nl4YqtQhFAvB5Zejk868J2B
         dpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789495816; x=1790100616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wVBxclk9QgEAlFYkz8nlTTQ0570gfN7zk+u3PBMIQfU=;
        b=q6RdcLp6Zzv4EVolLYQ3ziFrO5XiDYU2+Y8DdObTVrKts7Z78+jkmtZdF25iEZydB8
         NiihISd+egFrnbFWnzrHjzzkM0mQsqc2BFI+m6XNB2ni+h5vczqlyx69RlLb9IhkYRQD
         b+upi7PtdPyfulKzppyw5ztWfX3ut87W+rqBTTt3htvibBdhj8wzN4z7cxgKN4dcmkU7
         TlI6kZHXtUc8qVvkLzUgtir1RBOvJUDkHwsd5NYgUj1l3Rri4X4JosRJM8eS0WAa57/r
         jfiTTGj4OMiosXBwbAQHDSZ4uSD/Uln0yAXO3cu3ksu9Noj6wGTbMGJl/3JPeFF5tAGY
         XxSg==
X-Forwarded-Encrypted: i=1; AKwUvBzMpse46ioK9sAVcwy+PuIr/GZQFnKr1R2CP+tKFCmhLw/2AqEgwTpaxl40qBc0ZkYLbEx+PsP1VcA=@vger.kernel.org
X-Gm-Message-State: AFuF++mH4eg8Fzyk/FbWinRafHakN0L9dc4aWzleKKqMUJXLOMfmejjQ
	OwXXyV8qSAvtyO7KYV/LpUqr1yGbSi9oe5Jvqhd7Lo8LNsnYvw5uUWLrdMvyzgObfJA=
X-Gm-Gg: AYBFou2KHP6ExyRKzXWm657YbVronurKwOEvqIuxIsy4vaIqveHTPo+q3OWBef4TyRc
	nQnrlHsc1YtniAHBGTDcbXEX3gPqy+iMslMF9WvLOgzgptBIVijAevpXrzd1MyBna4Ou/D2bQKk
	2lTYX6+uRhc+4AAyYnE6/mjyIJltztzpYAHDD9iRbKlCi8Wxwb3MuTOvTWdN/0Km5gTN2i5BcDI
	lmu5M458ARoBmf49ULLlh2kFOKg6qeMJrOgbB+a5GiZZpO5XB0CeblcXVI6f85A7dXruRcWyGhx
	XRFCRIhyhEnfsrrkzEA8ClormTvjcHg3cbJUKRQHGajbKxDOAtMe54514xNb1vWJmfZ+9F/oNJ4
	dKsWnjT3mCdbDMYdcuxFeClPm73LW9JrqtB3rxv2MJob/Z8pkxfro2NlXuRlAqG1wbMLk5CLvTw
	AKDHkmFSdB6V4MMY/ShGfBRvEPFIe7mY6d3M9mAzH51JWbznYUajEzcGL3oGUGmeXJqjf5BvkQ7
	G8=
X-Received: by 2002:a05:620a:640b:b0:939:e735:c50e with SMTP id af79cd13be357-93a297c8d0fmr1256082585a.13.1789495811337;
        Tue, 15 Sep 2026 11:10:11 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b7824f72fsm14648485a.28.2026.09.15.11.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 11:10:11 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	bhelgaas@google.com,
	andersson@kernel.org,
	konradybcio@kernel.org,
	abelvesa@kernel.org
Cc: daniel@riscstar.com,
	mohdayaa@qti.qualcomm.com,
	lbiancon@qti.qualcomm.com,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] arm64: dts: qcom: qcs6490-rb3gen2: add endpoint buses
Date: Tue, 15 Sep 2026 13:10:02 -0500
Message-ID: <20260915181003.1633543-4-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915181003.1633543-1-elder@riscstar.com>
References: <20260915181003.1633543-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TC9564 SoC incorporates a PCIe switch, which is connected via
the second PCI segment (0001) on the RB3gen2 platform.  The third
downstream port of that switch (pcie@3,0) has an embedded PCIe
endpoint that implements two PCIe functions.

The SoC implements other peripherals, and they will be accessed via
PCI endpoint bus.  Define the devicetree nodes representing these
buses, including the mapping of each BAR's address range to its
local address space.

The endpoint's ranges property must be defined, but it will be
updated dynamically to include all BARs.  As a result of this update,
the parent address portion of each range will reflect the specific
address assigned to the BAR.

Co-developed-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
v3: - Updated ranges property "parent" addresses so they're unique

 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 30 ++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 3bb5fca8e2b13..5b7f5292a8864 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -955,11 +955,41 @@ pcie@3,0 {
 			bus-range = <0x5 0xff>;
 
 			dev@0,0 {
+				compatible = "pci1179,0220";
 				reg = <0x50000 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				/* Ranges will be updated dynamically */
+				ranges = <0x0 0x0 0x0  0x83050000 0x0 0x0  0x0 0x4000>,
+					 <0x2 0x0 0x0  0x83050000 0x0 0x4000  0x0 0x80000>,
+					 <0x4 0x0 0x0  0x83050000 0x0 0x84000  0x0 0x200000>;
+
+				pci-ep-bus@4 {
+					compatible = "simple-bus";
+					#address-cells = <1>;
+					#size-cells = <1>;
+					/* Map 0x0-0x1fffff to BAR 4 */
+					ranges = <0x0  0x4 0x0 0x0  0x200000>;
+				};
 			};
 
 			dev@0,1 {
+				compatible = "pci1179,0220";
 				reg = <0x50100 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				/* Ranges will be updated dynamically */
+				ranges = <0x0 0x0 0x0  0x83050100 0x0 0x0  0x0 0x4000>,
+					 <0x2 0x0 0x0  0x83050100 0x0 0x4000  0x0 0x80000>,
+					 <0x4 0x0 0x0  0x83050100 0x0 0x84000  0x0 0x200000>;
+
+				pci-ep-bus@4 {
+					compatible = "simple-bus";
+					#address-cells = <1>;
+					#size-cells = <1>;
+					/* Map 0x0-0x1fffff to BAR 4 */
+					ranges = <0x0  0x4 0x0 0x0  0x200000>;
+				};
 			};
 		};
 	};
-- 
2.53.0


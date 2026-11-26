Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795681898;
	b=If/9CEailb4yiIDncuaGUl7A+3YQbM41UNKa6fYoTURHcnhDDIdreiNSjphBWx9MMhYn
	 4oToU0LzOqD0lpLVAezf50t/SdkjrNlDhLRH5p7mZ4LqAIiL6YPLEiyOP+dWc+rb8TZwf
	 PB2KLtMObS4uH6vQDXspCXQgNr0MU+qbO5qGzUu8hllmNPB6KgyPvMwhGDaDR/4u/7gHm
	 Ejib3nhwrwS62ENJLNpz/E/mNPs3i/RxFo9I+N85utBA2Nov0+0tG7/8iOJmNqXfmN9TX
	 ptDb6WEwTohvM6U4xorpAbZHqX/N51t02lO0EV7TL5QImDfDDS8iFABsaJfD9WRmHEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795681898;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=08OZORRcrcIF2Ty+sn3CWx4/XSYv/+hAVznOdrM2vx0=;
	b=RILQXYCPVLH9slPZvQpXmRETAIRjrhm9+XBV2TJ0HTFGB81r88FRu0tSg1PVcu7m0rHn
	 p18hp9t4f0/f9xke6Dkata9BNwDev0K1TGUkjXS31Pfr3GPZHVuqIlBBAifMC111JOC4O
	 anW6Hu9cAma+Y8Mwq1h/o/8pugQKIhMGMixIk3LNT0VyZOAE0ILlXG3x7rKs/Ry2CKXRp
	 TUSIh5is3n8Y0cuMsVegb84olFRvmSmiycCsFU5wwVnGbSDCR4xTDezugP6bkj3YsxnM0
	 FoxLgS385WoLFk8pL+fFC2IEgd/OKjAalkFHeO3LHaalr+9Frc5Ejdy0Uf/RCyIf7Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WLS6eO1W;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CwPosNui;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087C2606A321
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 08:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 087C2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WLS6eO1W;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CwPosNui
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7j3gp132093
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 08:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=08OZORRcrcIF2Ty+sn3CWx
	4/XSYv/+hAVznOdrM2vx0=; b=WLS6eO1WUscobvNqvXnQYhM8FLoWi1OatGlVQI
	k/dFFEJk/rskX8mIgC7r20iS2pakzRlO/w1ZrVyfZlsmqjWvTwtM+90kRsUtXKz1
	5M+JCJQ7g1Eeti+XQkoeK3GaKJWr0C0mjbbF2j05G272PUAGdBxJwLsKvYK0SCfp
	+Ao0hdvPVvA9hAKN859qiIMv1jdWx4+w3OzHn0WB+EKNaxfa3gcIIrMXlgF0ef+o
	w0s+3W71mZJD/G7HkRp+5jBS7uEh84gQoe3tj93SVHk9iI7hpp6zWAyacFJcFh50
	ePkqCJ77g/XFulC785RKiC+00Y/MVh5iRYV5QgeYx/nZi5hA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6gne055x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 08:31:34 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1383723dfddso6919502c88.0
        for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 00:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795681608; x=1796286408; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=08OZORRcrcIF2Ty+sn3CWx4/XSYv/+hAVznOdrM2vx0=;
        b=CwPosNuiyzPHfgZSHB0UL7zIQyk/vIMc86LhipcmhPan4TIwmuOdJ+zb203SSTuAf5
         Lf/4OXpp21Py8uSK90LUvjyNA8fDfmUP7xB6K9HK8+izd/fEPwjwt2I4ynMeTCmlZ5+L
         O/I/SB/FNEi0kInlCjMWR5j3Mg807QncjhUfS2UTzBCYskUyXi03wbqh/1pJqGu915Au
         IM3koylnQH0B6S3Ya0HROuOgIxSV0o22FQ6zGeWPc/kvarjZnNNYrQjyMc9uYX4t1ZE/
         e9WDa0LYzRvOJD6i7g4qZW2uqnOcjnRpyHQQs8kAaw1llNbuQ5bebd2ndiYg8yBmzGgP
         4KOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795681608; x=1796286408;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=08OZORRcrcIF2Ty+sn3CWx4/XSYv/+hAVznOdrM2vx0=;
        b=qQYt6GJTGdXgsulNewgcPqGQz8zzD/Owj4f9Xm1UoAh957Eq4vtiZVJEhd6cbvJj3U
         SlS+l+CGdxcDZ8V1y6OK2rLDHncsjZzBl1ZHJWVUZcZgd9pjWHor8+zAoaRG+Iz8yLUL
         dtGWbN1l7NRh7bPKGtBrx8tqnGFlZmKOpzvBtrmr+2464Bo9q2N9fx3PZpl9YByPUeBX
         91XaOE5es9+bj1naPSycisoaDikQ3pvv6Wylx5/GJWW+d7VoTZ8Snu/I46RM591ZQpU3
         ZtN8bST578VKjOu2NALEx3/AhCT+XIEqZKKRrajjgVb7kF7mU0EaW5ml4CQHTAi1aTtJ
         64zg==
X-Forwarded-Encrypted: i=1; AL+hErGvlOrtzAMGczRfmfVD1ZymLyW34lyTD6b38j6SfgKnAbO1JxQqY8o8TI4gyorpRvQY73ug+Rlm2rM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/l/ogEeW1TSgDnUBOTXdf24E8tpqAngfcmenao+9JVsXUdzbAH
	iQB56Njv/7ioJ8dBMtTos2M1kVljlxQ0Awb/z5NFM1zKdRBD3iYUAs+tlsJNjFZ8B+hxLZFJSua
	xE/sagqnIyCRSaaTVFvOfQgiOyaThEKYiEnbbIhY6Lr5lYpQjtMdDSdjGjIWbly5xGCQPWMI=
X-Gm-Gg: AZFdTZeOX73K9VFVaiyYlEenW+nnT3cs/drlAIxvzB8JvA33B7x3JhBMmexwh20WR82
	Uj0rLp0xLQGK8UNA4zlG5joVzvniIOiukHqAVi6mgvGAYtEg71lExAEPdNuFWX4fLPBP3VmVnyg
	Y2MWuky+ulAfmvU9C0QXJHvlc9NxoG8VYYuWk6n3+DI4ujZEB613j963p/Df94FIX3srxqM5IKz
	r6QqDBJlZ+MWSRwQc3Z2orxxMdck8PIIGFZMMhBiwt5XganvARMCmjx8n1YdIe5RHRaj30m/pza
	ho/EYIcbOUWJl9zKqjLBuWH0jU4jKE0oKufZNRoU3ICF/MlwP79/JL1gLOvZWn0iM3Yx/f5ckif
	6eI68xdTofI1iuJ6detvrbrIhIhCWu3AlEUAtlFrZAHI0IDWPbYB4cINKU4U+L6M2iUKsUEHCFW
	kYD4cFjRN8ZooxcxvD09mE
X-Received: by 2002:a05:701b:2816:b0:1b5:3b83:5374 with SMTP id a92af1059eb24-1b5568cfbd9mr18298109c88.19.1795681607813;
        Thu, 26 Nov 2026 00:26:47 -0800 (PST)
X-Received: by 2002:a05:701b:2816:b0:1b5:3b83:5374 with SMTP id a92af1059eb24-1b5568cfbd9mr18298047c88.19.1795681606978;
        Thu, 26 Nov 2026 00:26:46 -0800 (PST)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5566c1142sm46350056c88.2.2026.11.26.00.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 00:26:46 -0800 (PST)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 00:26:45 -0800
Subject: [PATCH RFC v2] PCI: pciehp: Fix AB-BA deadlocks between
 reset_lock, pci_rescan_remove_lock and pci_slot_mutex
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
Message-Id: <20261126-fix_deadlock_1126-v2-1-c0ed50bc7b04@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAETtB2sC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzNDQyMz3bTMiviU1MSUnPzk7HiwiHmSZVKKaUpiSqqpgRJQX0FRKlAR2Mx
 opSA3Z6VYiGBxaVJWanIJyDSl2loAQOP/KHoAAAA=
X-Change-ID: 20261126-fix_deadlock_1126-7b9bd5dade50
To: Will Deacon <will@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lukas Wunner <lukas@wunner.de>, Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795681606; l=12772;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=ZzSEUpv9PtF3JkDwBNC5Tunf3/kyG4FqNS8I4HF/Hts=;
 b=4Qv5+v8z0bwObSvYVi4EP0+KB5+72NYGb5KTmp+33PDmawvgPZdlLIeiXAiRaQh3mhEgF/00L
 dopDdE96jFaByX6XUm60LEQ3j/buW3IKZCqjO0oC6GT389YHMCdkra2
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Authority-Analysis: v=2.4 cv=XpVvqlF9 c=1 sm=1 tr=0 ts=6b07ee68 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=wr20Ner3HAe7Lg71fTsA:9 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzMiBTYWx0ZWRfX7O/V5ZopEKYp
 eQxW52C7HwzPUqTIrOpqqxxnwcsMzj57cmz9IjwcsCJFzbli1/w30EClwWbvvXGL2kREowL4Iq+
 2hDJrSzVbkwnOC9w7FS2B3KV2Nmx8Egg6WACEfi4gMUhQ9HAGrIPqI63fHnZvTDr/Lzje6Non94
 pStqvaVvwBy2WbdupEkGLzlZMbo1HAETZUXxwN9SsDIeSfCGSiLzhjt3NIq0qrP/yuIg41qBkSf
 8vA7Agp4PD6KaaYPZGL7kaffLJSUiOE3R8gguf1X5VqOIYPVHWAjCIuVIeenR5B8Jm9Ysa5/vum
 JRxjVRDI6JNS+tPG0L6pQgpsKaA1cRqjfoLiM2R7mQF+r2pSeVt2gOgj3/RrhE7cogHtM3+REnf
 iNmgA//ugD4u6/lP8+cEvi/G240N/s2ekeckZ49qSZNG/Cldsh/Vrr4AQIX/DnxfQ0thkuyLBFd
 mWUj78a8boeDYq+Dn0w==
X-Proofpoint-GUID: -nwrGVTomJlBaBVeD-zsMS71aBghTE6o
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzMiBTYWx0ZWRfX+Ui/c7OEeI9a
 A+hZIC3zefYmo1fCckCQWSKNap+4ybYM3sOBhzFZ4aAPhDyIrTnpuFcOQ4f8A+pT8Lf5e6LW4A0
 wyn1Nq54fnXRgm2LxSfKCJnsJbUtMtE=
X-Proofpoint-ORIG-GUID: -nwrGVTomJlBaBVeD-zsMS71aBghTE6o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260032

Commit 5b3f7b7d062b ("PCI: pciehp: Avoid slot access during reset")
introduced ctrl->reset_lock to serialize a Secondary Bus Reset (SBR)
with the pciehp code paths that read the Link Active and Presence
Detect bits, both of which flap during an SBR.

pciehp_ist() holds reset_lock across the whole event handling,
including enumerating or de-enumerating the hotplugged devices. That
nests two PCI core locks inside reset_lock, each taken in the opposite
order by a concurrent SBR, causing two AB-BA deadlocks.

First, reset_lock vs pci_rescan_remove_lock. pciehp takes them as
reset_lock -> pci_rescan_remove_lock:

  pciehp_ist()                                 # down_read(reset_lock)
    pciehp_handle_presence_or_link_change()
      pciehp_enable_slot()
        board_added()
          pciehp_configure_device()
            pci_lock_rescan_remove()           # pci_rescan_remove_lock

A Root Port reset from link-down recovery takes them the other way
round, pci_rescan_remove_lock -> reset_lock (the boot path, via
pci_host_probe(), takes the same reverse order):

  qcom_pcie_global_irq_thread()
    pci_host_handle_link_down()
      pci_host_reset_root_port()
        pci_lock_rescan_remove()               # pci_rescan_remove_lock
        pci_bus_error_reset()
          pci_reset_bridge()
            pci_slot_reset()
              pci_reset_hotplug_slot()
                pciehp_reset_slot()            # down_write(reset_lock)

Second, reset_lock vs pci_slot_mutex. pciehp takes them as
reset_lock -> pci_slot_mutex:

  pciehp_ist()                                 # down_read(reset_lock)
    pciehp_handle_presence_or_link_change()
      pciehp_configure_device()
        pci_scan_slot()
          pci_scan_single_device()
            pci_device_add()
              pci_dev_assign_slot()
                mutex_lock(&pci_slot_mutex)    # pci_slot_mutex

An SBR of the same hierarchy (AER- or link-down-induced Root Port
reset, or a sysfs "reset_subordinate" request) takes them the other
way round, pci_slot_mutex -> reset_lock:

  pci_bus_error_reset()  /  pci_try_reset_bridge()
    pci_reset_bridge()
      mutex_lock(&pci_slot_mutex)              # pci_slot_mutex
      pci_slot_reset()
        pci_slot_lock()
        pci_reset_hotplug_slot()
          pciehp_reset_slot()                  # down_write(reset_lock)

The second deadlock constrains the fix: pci_reset_bridge() must hold
pci_slot_mutex to walk the slot list before it can reach
pciehp_reset_slot(), and pciehp cannot reorder that. As long as pciehp
holds reset_lock while descending into pci_scan_slot(), the reverse
nesting is unavoidable regardless of pci_rescan_remove_lock ordering.

reset_lock only needs to protect the register reads against a
concurrent SBR, not the enumeration itself. Fix both deadlocks by
dropping reset_lock across the whole scan/remove section in
pciehp_configure_device()/pciehp_unconfigure_device(), extending what
commit f5eff5591b8f ("PCI: pciehp: Fix AB-BA deadlock between
reset_lock and device_lock") already did around driver binding alone.

Without reset_lock there, an SBR can again race pci_scan_slot() and
leave a register unreadable during enumeration, so the device fails
to be enumerated correctly. Hand that serialization to
pci_rescan_remove_lock, which already spans the scan.

pci_reset_bridge() and pci_reset_bus() issue the SBR unconditionally,
with no check on what else is on the bus, so they need
pci_rescan_remove_lock. pci_host_reset_root_port() no longer takes the
lock itself, since pci_reset_bridge() now does.

pci_reset_function()/pci_try_reset_function() are left without the
lock: their SBR fallback (pci_dev_reset_slot_function(), then
pci_parent_bus_reset()) only fires once it confirms the device is the
sole occupant of its bus, so it cannot race the scan that populates
that bus with a sibling device. And being able to call
pci_reset_function(dev) at all means dev is already fully enumerated.

vmd_enable_domain() calls the new pci_reset_bus_unlocked(), skipping
pci_rescan_remove_lock, since it runs from vmd_probe() with
device_lock already held and taking the lock there would invert the
lock order. This is safe because there is no concurrent scanner to
race: the VMD bridge was found by the initial root bus scan, and any
hotplug controller below it does not exist yet at this point. Neither
that scan nor pci_scan_child_bus() earlier in this same function was
ever protected by reset_lock.

Fixes: 5b3f7b7d062b ("PCI: pciehp: Avoid slot access during reset")
Fixes: 4c99bace4f4e ("PCI: host-common: Add link down handling for Root Ports")
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
Changes in v2:
- Rebase on latest pci main branch
- Link to v1: https://lore.kernel.org/all/20260817-ab-ba-deadlock-v1-1-e619fd07d1fd@oss.qualcomm.com/ 
---
 drivers/pci/controller/pci-host-common.c |  2 -
 drivers/pci/controller/vmd.c             |  2 +-
 drivers/pci/hotplug/pciehp_pci.c         | 24 ++++++------
 drivers/pci/pci.c                        | 64 +++++++++++++++++++++++++++++---
 include/linux/pci.h                      |  1 +
 5 files changed, 73 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index a23907a875e5..299248316b4c 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -329,9 +329,7 @@ static pci_ers_result_t pci_host_reset_root_port(struct pci_dev *dev)
 {
 	int ret;
 
-	pci_lock_rescan_remove();
 	ret = pci_bus_error_reset(dev);
-	pci_unlock_rescan_remove();
 	if (ret) {
 		pci_err(dev, "Failed to reset Root Port: %d\n", ret);
 		return PCI_ERS_RESULT_DISCONNECT;
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 9d97a832785e..9350fda6cb4e 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -1112,7 +1112,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		if (!list_empty(&child->devices)) {
 			dev = list_first_entry(&child->devices,
 					       struct pci_dev, bus_list);
-			ret = pci_reset_bus(dev);
+			ret = pci_reset_bus_unlocked(dev);
 			if (ret)
 				pci_warn(dev, "can't reset device: %d\n", ret);
 
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index 65e50bee1a8c..b2698a530f59 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -36,6 +36,11 @@ int pciehp_configure_device(struct controller *ctrl)
 	struct pci_bus *parent = bridge->subordinate;
 	int num, ret = 0;
 
+	/*
+	 * Release reset_lock before rescan/remove
+	 * to avoid AB-BA deadlock with pci_rescan_remove_lock.
+	 */
+	up_read(&ctrl->reset_lock);
 	pci_lock_rescan_remove();
 
 	dev = pci_get_slot(parent, PCI_DEVFN(0, 0));
@@ -64,13 +69,7 @@ int pciehp_configure_device(struct controller *ctrl)
 	pci_assign_unassigned_bridge_resources(bridge);
 	pcie_bus_configure_settings(parent);
 
-	/*
-	 * Release reset_lock during driver binding
-	 * to avoid AB-BA deadlock with device_lock.
-	 */
-	up_read(&ctrl->reset_lock);
 	pci_bus_add_devices(parent);
-	down_read_nested(&ctrl->reset_lock, ctrl->depth);
 
 	dev = pci_get_slot(parent, PCI_DEVFN(0, 0));
 	ctrl->dsn = pci_get_dsn(dev);
@@ -78,6 +77,7 @@ int pciehp_configure_device(struct controller *ctrl)
 
  out:
 	pci_unlock_rescan_remove();
+	down_read_nested(&ctrl->reset_lock, ctrl->depth);
 	return ret;
 }
 
@@ -104,6 +104,11 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
 	if (!presence)
 		pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
 
+	/*
+	 * Release reset_lock before rescan/remove
+	 * to avoid AB-BA deadlock with pci_rescan_remove_lock.
+	 */
+	up_read(&ctrl->reset_lock);
 	pci_lock_rescan_remove();
 
 	/*
@@ -116,13 +121,7 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
 					 bus_list) {
 		pci_dev_get(dev);
 
-		/*
-		 * Release reset_lock during driver unbinding
-		 * to avoid AB-BA deadlock with device_lock.
-		 */
-		up_read(&ctrl->reset_lock);
 		pci_stop_and_remove_bus_device(dev);
-		down_read_nested(&ctrl->reset_lock, ctrl->depth);
 
 		/*
 		 * Ensure that no new Requests will be generated from
@@ -138,4 +137,5 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
 	}
 
 	pci_unlock_rescan_remove();
+	down_read_nested(&ctrl->reset_lock, ctrl->depth);
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c6f2aba8144..211808f7bd1f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5750,6 +5750,13 @@ static int pci_reset_bridge(struct pci_dev *bridge, bool restore)
 	if (!bus)
 		return -ENOTTY;
 
+	/*
+	 * The reset below may issue a Secondary Bus Reset, which races with
+	 * pciehp enumerating a newly inserted device. Serialize via
+	 * pci_rescan_remove_lock; callers must not already hold it.
+	 */
+	lockdep_assert_not_held(&pci_rescan_remove_lock);
+	pci_lock_rescan_remove();
 	mutex_lock(&pci_slot_mutex);
 	if (list_empty(&bus->slots))
 		goto bus_reset;
@@ -5769,13 +5776,17 @@ static int pci_reset_bridge(struct pci_dev *bridge, bool restore)
 	}
 
 	mutex_unlock(&pci_slot_mutex);
+	pci_unlock_rescan_remove();
 	return ret;
 bus_reset:
 	mutex_unlock(&pci_slot_mutex);
 
 	if (restore)
-		return pci_try_reset_bus(bus);
-	return pci_bus_reset(bridge->subordinate, PCI_RESET_DO_RESET);
+		ret = pci_try_reset_bus(bus);
+	else
+		ret = pci_bus_reset(bridge->subordinate, PCI_RESET_DO_RESET);
+	pci_unlock_rescan_remove();
+	return ret;
 }
 
 /**
@@ -5805,19 +5816,62 @@ int pci_probe_reset_bus(struct pci_bus *bus)
 }
 EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
 
+/*
+ * Core of pci_reset_bus(), run with pci_rescan_remove_lock already held or
+ * known not to be needed.  See pci_reset_bus_unlocked() for the latter case.
+ */
+static int __pci_reset_bus(struct pci_dev *pdev)
+{
+	return (!pci_probe_reset_slot(pdev->slot)) ?
+	    pci_try_reset_slot(pdev->slot) : pci_try_reset_bus(pdev->bus);
+}
+
 /**
  * pci_reset_bus - Try to reset a PCI bus
  * @pdev: top level PCI device to reset via slot/bus
  *
- * Same as above except return -EAGAIN if the bus cannot be locked
+ * Same as above except this blocks until pci_rescan_remove_lock can be
+ * acquired, and still returns -EAGAIN if the underlying slot/bus device
+ * lock cannot be taken.
  */
 int pci_reset_bus(struct pci_dev *pdev)
 {
-	return (!pci_probe_reset_slot(pdev->slot)) ?
-	    pci_try_reset_slot(pdev->slot) : pci_try_reset_bus(pdev->bus);
+	int rc;
+
+	/*
+	 * pci_try_reset_slot()/pci_try_reset_bus() below may issue a
+	 * Secondary Bus Reset, which races with concurrent bus scanning.
+	 * Serialize against that via pci_rescan_remove_lock, taken before
+	 * the slot's/bus's device locks to match the lock order used by
+	 * pciehp.
+	 */
+	pci_lock_rescan_remove();
+
+	rc = __pci_reset_bus(pdev);
+
+	pci_unlock_rescan_remove();
+
+	return rc;
 }
 EXPORT_SYMBOL_GPL(pci_reset_bus);
 
+/**
+ * pci_reset_bus_unlocked - Try to reset a PCI bus without taking
+ *			    pci_rescan_remove_lock
+ * @pdev: top level PCI device to reset via slot/bus
+ *
+ * Same as pci_reset_bus(), except it does not take pci_rescan_remove_lock.
+ * For callers reached from a driver .probe callback, where pci_rescan_
+ * remove_lock may already be held by the caller of pci_bus_add_devices(),
+ * or may not be held at all; taking it here either self-deadlocks or
+ * inverts the pci_rescan_remove_lock -> device_lock order.
+ */
+int pci_reset_bus_unlocked(struct pci_dev *pdev)
+{
+	return __pci_reset_bus(pdev);
+}
+EXPORT_SYMBOL_GPL(pci_reset_bus_unlocked);
+
 /**
  * pcix_get_max_mmrbc - get PCI-X maximum designed memory read byte count
  * @dev: PCI device to query
diff --git a/include/linux/pci.h b/include/linux/pci.h
index aa3765a20a96..286867395072 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1492,6 +1492,7 @@ int pci_try_reset_function(struct pci_dev *dev);
 int pci_probe_reset_slot(struct pci_slot *slot);
 int pci_probe_reset_bus(struct pci_bus *bus);
 int pci_reset_bus(struct pci_dev *dev);
+int pci_reset_bus_unlocked(struct pci_dev *dev);
 void pci_reset_secondary_bus(struct pci_dev *dev);
 void pcibios_reset_secondary_bus(struct pci_dev *dev);
 void pci_update_resource(struct pci_dev *dev, int resno);

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261126-fix_deadlock_1126-7b9bd5dade50

Best regards,
--  
Qiang Yu <qiang.yu@oss.qualcomm.com>


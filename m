Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20A227C162
	for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 06:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787034867; cv=none; b=YUqpVkZjnbrbjDOZgca2c8vgl3A96RBa43iQIiMR82qPni9zhyhFdQmKXzny5BKmuKFtVCA4xGvcKRZILQ+1m5faxGUdzKvOO7/SThFdEIVC35YDWLa396tRx8NgEE73t8rVQuvgdDyzrP3jhHAjpihQfVNBWJblFX2vZ/nj5EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787034867; c=relaxed/simple;
	bh=s5EJ3Y+80mzIdYusQldsuLpi2MqNK3JHswa0TZRIXV8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=J6zZuvtmxld3jcZMTZJ7LVkJQgmzzG7Sx5TAcpxxzTV8R7iXBuzHPrHAjkGi5ImpknZSl4a6lKKuxgChGEMBWf3GgTAyhEcsXZxlWJMKiGBfXw371/7l0tBJJ5brUQF4t/kMWshQDjfW+Rsoido6p65H12fAh8atWZ2wvrUkiOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C0BhCuyw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cWHRkPyu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C0BhCuyw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cWHRkPyu"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I3iMT91171849
	for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 06:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Cxx8HpmhSn5XafQ7Spacdg
	3CXM91BaRezAvZeqeC4Bo=; b=C0BhCuywY2G5h1gF+RiFoIg86oThEEUYQQFP4f
	RqGoslIsvzSGCwf91elNvgIEHrD/VLkdl1q+xGhX/A8+hrvN+r8vJ0yemHCZPBOr
	ThOTONFkylhUM5nVBOX00zyPDpYKHQw1I+Ur+sO6jTf26TZU9vdDvegTVBbwixS8
	KQnVfCHvJucRuCTnr/59hkawada7YxPJgreimDuarGH6wOhXRCxC0BmnKuoAK0Az
	0P5F1nVaLqJVWLqgZCXUdNAL3rJ4BrnBJCos0F5ee0fOG42d5E3pkVtgmlYSkL1o
	dc7LHVcx3Fr0Ej+NnKH7uM9DliiDbL7Gx9VThK6tzaPAEruA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4frmrpsa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 06:34:23 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so7055019a91.1
        for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 23:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787034863; x=1787639663; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Cxx8HpmhSn5XafQ7Spacdg3CXM91BaRezAvZeqeC4Bo=;
        b=cWHRkPyuyrTz1Uk5f0KhkSWJmU5ZO74nibonaTf7Zf9hUvwb9l+mZy2DofFMgnmqbb
         I/x8iJb2Iagv6jzuahHgF3Llrh9jKhDFx+SgmSwTKZ7d3xotBL2bE/OKzCQNLntSV1cY
         ry9uyPwnA/4aC3tehcE3ov84/NlOuAcfmQ7RAqG2knPQBDktpO6vIatwJPk8NgO/Q0yd
         CUGVpfzfHeEutCdvRht0m0XtwQcxLEbWFZsizDdM6ped1TFuWKN11pwb2s4wcnBuHCOj
         oQPHlnuByGfaL4BzGdpWOWVIBdtJCj8r37pMcZS1+ZeyN9I0JnHMKgPYu9iCAnvorOQa
         u4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787034863; x=1787639663;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Cxx8HpmhSn5XafQ7Spacdg3CXM91BaRezAvZeqeC4Bo=;
        b=tMFJfHVTeKZmcde1SeDCycuZHbJ85do1nOZ80vV+gUiv5cHzN8zxwDGPIaolJrFr3k
         kV+vh4QNWMz3AiT6BPvVn2rq48dk9ynzkmzHIBFP6p1xgFzB7kE5uD9bWvg9+ASqDJvx
         6l9CAv7D8yzzuuoAnLUaMgt+2kRU1OfeYeb4HZFGIDtBV18oluic8EFiSs6go46Q5niR
         VHNJBUzDRkIM9CnX8zL4e5i/2wCgfONYirl0QVCOUqG/XY0JMeAbnRg1aCtUE/6oePYg
         Dp54gIseSxEYPAlBy3dxGemPALkCNZQnj4w5MP3RH02loWnkfzqc5s4OFk2qcmSKJ+DL
         Y1nQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr3Cnk43fSMWCNPeSgKuaJ0QiarZLGye1UGvHxmCqI5Je3rd5zM92iGNuSx0ZigXnu4UmwgFN67MLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFwhE9UzsDKRRd/90UkF83uZv8Llg2y31521VZE5RKinftwpr3
	HxRcZ15sM+xUL6fKi7BHu0Vaj1Oq2kctW5mxz1rAOROeCArWEes23DI/fcv/l201HCKqx3qGE4/
	KcOiRj2CW+7mUV36MNbtFq1QkwdM+5pCzcsu4HGmIMsK/6fL76rGbO7wzqeHDR9k=
X-Gm-Gg: AR+sD12OyAaJFQA3m4eL0F46e07+RL3lT4Jui9dmxp7MfTCOLr/4+Y0D/Jgkfx7oGuA
	Ntdwc+48QF/qcS0CNKsf8JD/YLrrwG5evt6x6pPuYz/CFL+10Qv/OwIUif5pwZSzZKxOOxMKuD7
	NfpOLRr1F4fo8kMD2dUBtp4rWUK8+5GdyrtjH3YzSnDKZgqIQ+9HQEvYhwQUQFZMcWggR6zYG8y
	o3Bz3BKo8CKceIQ3em2NvJLsh/o9L/8hrFBtefJXifNV/AZglB+dvTwCJvMy28qsgccut0qUgfj
	6mjo5cWDHbWehfDmWrcJ+uCbnhFmny30HDnQp//awYDF2mIXbuDFqjRq/AUdicGByiiCbdz7/9b
	FCtLGzQUKIvczkUwcohiQT2ZAIiwZ+rwlZlEYBPuhVpEpIf0=
X-Received: by 2002:a17:90b:1d01:b0:38e:9045:babe with SMTP id 98e67ed59e1d1-3933b75535cmr32045254a91.7.1787034862791;
        Mon, 17 Aug 2026 23:34:22 -0700 (PDT)
X-Received: by 2002:a17:90b:1d01:b0:38e:9045:babe with SMTP id 98e67ed59e1d1-3933b75535cmr32045168a91.7.1787034862271;
        Mon, 17 Aug 2026 23:34:22 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e31b8fsm7489003a91.3.2026.08.17.23.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 23:34:21 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 23:34:15 -0700
Subject: [PATCH RFC] PCI: pciehp: Fix AB-BA deadlocks between reset_lock,
 pci_rescan_remove_lock and pci_slot_mutex
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-ab-ba-deadlock-v1-1-e619fd07d1fd@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOb8g2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0Nz3cQk3aRE3ZTUxJSc/ORsXWPTZKMUi+REI3OLVCWgpoKi1LTMCrC
 B0UpBbs5KsRDB4tKkrNTkEpBRSrW1AIa8Dv53AAAA
X-Change-ID: 20260817-ab-ba-deadlock-35c2d8ca278e
To: Will Deacon <will@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lukas Wunner <lukas@wunner.de>, Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787034860; l=12608;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=s5EJ3Y+80mzIdYusQldsuLpi2MqNK3JHswa0TZRIXV8=;
 b=DmKbo+goGuksYtkq7kgj6lN+6WkrZ10l3hYqU3FWHvBfr4twQmkasAsr16ehw+WRRHWGpcwp3
 L++zZesXAaaDCMwwcRBiuSEpAhBOOnGKxlVbNg4+lijYjHFNSkbQbVV
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA0NyBTYWx0ZWRfX46wUniHAsFoQ
 GJalUO9frfeSEdzdVk9Irx/kEBigxDmKVYuxPlEMt18Ffnwtn8DOc/7rioV5pCTYvGnH2DQiO68
 Jg/v95ebGW9pCf1uROFEsNbVj9eTs85ZMuHpdonDuvtwc3OfJiF6paNzLN5Mp08tciVVkivlODZ
 wF+zk91xDMlNCdeG/apzPvgv+sr2bgBaiK4DsWzI5N2RZeShxGGRBxcci0VNozcVSCL9K319wzl
 krPVC2jk3cpT444D3mclG9TcKHQC/NH1d/1EjU/ICOcK0o0IthJyf23oEy5wHFebiI+MMOIZIzL
 5pn3n17NaG8ZtQGxXPhxNGXzabiDuIb68VJziP4wcnWt0h5E9Eg/gXSxZV63Qg3jKYnJkq15v07
 drg2wJUmxZ3jwx3TS944PmZRtTvUAOJzU8zrxLghx+L6wSjuhBf3jfb78Rnz2F5ZUsOBQ0n0nll
 ODi/r6zKrAHZGinXrXg==
X-Proofpoint-GUID: dsu27qMzTVr1kshLSAN01fuyMklDsk9y
X-Proofpoint-ORIG-GUID: dsu27qMzTVr1kshLSAN01fuyMklDsk9y
X-Authority-Analysis: v=2.4 cv=GtlyPE1C c=1 sm=1 tr=0 ts=6a83fcef cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=wr20Ner3HAe7Lg71fTsA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA0NyBTYWx0ZWRfX0kG/HwwBHPj0
 zacxhe4nHA8KsVt30neldCxashCvNreqorDxo/k4qSFGH0bQfuvxVL4ojwQXGxQy+XbOHRpdRiy
 8rUkcc/GwOjcCG4tIAGh0ydHy3AYFCU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180047

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
index 9b283e151c1a..ac1311028003 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -1063,7 +1063,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
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
index b2879a6be5f8..9010741d032f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5704,6 +5704,13 @@ static int pci_reset_bridge(struct pci_dev *bridge, bool restore)
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
@@ -5723,13 +5730,17 @@ static int pci_reset_bridge(struct pci_dev *bridge, bool restore)
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
@@ -5759,19 +5770,62 @@ int pci_probe_reset_bus(struct pci_bus *bus)
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
index 90972c1dd8e0..642c16f8ecae 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1488,6 +1488,7 @@ int pci_try_reset_function(struct pci_dev *dev);
 int pci_probe_reset_slot(struct pci_slot *slot);
 int pci_probe_reset_bus(struct pci_bus *bus);
 int pci_reset_bus(struct pci_dev *dev);
+int pci_reset_bus_unlocked(struct pci_dev *dev);
 void pci_reset_secondary_bus(struct pci_dev *dev);
 void pcibios_reset_secondary_bus(struct pci_dev *dev);
 void pci_update_resource(struct pci_dev *dev, int resno);

---
base-commit: 03ffab4b0227353164147d7872e96d664d548259
change-id: 20260817-ab-ba-deadlock-35c2d8ca278e

Best regards,
--  
Qiang Yu <qiang.yu@oss.qualcomm.com>


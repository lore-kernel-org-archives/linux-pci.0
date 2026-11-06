Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982195;
	b=0k+eY5yzB1dLuTs9UQ8e4uM1BhN0M2u9CR9SxZ34tUwDkN5DZWVveoimDYE0S1v71PWA
	 1drUGrtDg0mT+Kg77PMtlBVJEIfoyqkHQl//2ihVV4j7N6vrVj8QvwkXB5QqPfbXveB+P
	 DZt34BESVNUUZFcWHGH7npLi3/zPgvDpvzz6/baFUImSLTmi9XfJsAXc7/bL5VFUj7t2L
	 kZrO80nSjvwDYGG8DA/fDlXKxCFu37BFbWVw35bz418DKPcmNUTxmxQ9JNq7lTSIZbsbZ
	 i1lOP1UBeBRxpdYkNc6lg3Hqyn+uecu0KZk90Ivi+EZB5ORFFMynpLkkPpEikhYRE5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982195;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=WfQG6NPUtmS4ZvN+fzcKamXJp/rcbxZu5GJRWpl9cQ4=;
	b=wyEWuw7akAlzrVsq2gd2bJdNjDegPuVxSbDeqCCux5oE9JX5orCdFKW2Y4fd5WP4Ik79
	 g/f0N5sxX/bmCCBn/5MZtWZoFn6IYmufo2aFEcrh02Tc+lnZ7NqviMkcqZNzX/yWrxLoj
	 DMJupTQ28APb4Jd/2INmauN8XRPTv2JlXTZP9xlMYriR+klyp6OWzS8dK6PsWWrp6iqTJ
	 qA50KAPzh4Cb4VhJzDdXeLH55oTpPFoCw4P8DcAO+U4GvXFtcE1eYdJsF3ffAWCNdfJg6
	 bjUqcFafbjU0J+ohZ8dU3jnV4PW7g94+gYDHhMwgHWLo9Y+p4cLC7PVRFvzl/JV3ksg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00436606A329;
	Fri,  6 Nov 2026 16:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00436606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jLkxX1TJ5z57DCj;
	Sat, 07 Nov 2026 00:23:12 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 6A6GN2mL089040;
	Sat, 7 Nov 2026 00:23:02 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 00:23:05 +0800 (CST)
X-Zmail-TransId: 2afb6aedfee91d8-bb14a
X-Mailer: Zmail v1.0
Message-ID: <20261107002305850zuBaVsGBz3wbco2Ae4ScR@zte.com.cn>
Date: Sat, 7 Nov 2026 00:23:05 +0800 (CST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Cc: <mani@kernel.org>, <kwilczynski@kernel.org>, <lpieralisi@kernel.org>,
        <kishon@kernel.org>, <Frank.Li@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDAvNV0gUENJOiBGaXggaW52YWxpZCBpbnB1dCBoYW5kbGluZyBhbmQgYSBOVUxMIGRlcmVmZXJlbmNl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A6GN2mL089040
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 07 Nov 2026 00:23:12 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEDFEF0.000/4jLkxX1TJ5z57DCj

Several PCI paths consume values from the command line, a device tree,
config space or an endpoint driver without validating them, and the
ASPM link setup does not handle a downstream bus without function 0.
The five fixes reject the bad values, or skip the unsafe state, before
they reach a shift, an array index or a pointer dereference.

The series is ordered by severity and is independent patch-by-patch;
each patch can be applied and reviewed on its own, and taking a subset
is fine:

  1/5 PCI: Reject negative resource alignment order
  2/5 PCI: of: Bound num_lanes in of_pci_get_equalization_presets()
  3/5 PCI/ASPM: Skip link-state setup without downstream function 0
  4/5 PCI: rebar: Guard pci_rebar_bytes_to_size() against overflow
  5/5 PCI: endpoint: Reject a zero interrupt number in raise_irq

1/5 rejects a negative pci=resource_alignment= order, 2/5 rejects a
num_lanes value larger than the 16-entry preset arrays, 3/5 skips ASPM
link-state setup when the downstream bus has no function 0, 4/5 rejects
resizable BAR sizes that cannot be encoded, and 5/5 rejects a zero
MSI/MSI-X interrupt number before it underflows in the controller.

All five are single-file changes under drivers/pci/ and pass git apply
and checkpatch.  Each patch was tested on 7.3.0-next-20261030 in a
QEMU/TCG guest with an unpatched/patched A/B comparison; the test
section in each patch describes the setup and the observed results.

Shao Mingyin (5):
  PCI: Reject negative resource alignment order
  PCI: of: Bound num_lanes in of_pci_get_equalization_presets()
  PCI/ASPM: Skip link-state setup without downstream function 0
  PCI: rebar: Guard pci_rebar_bytes_to_size() against overflow
  PCI: endpoint: Reject a zero interrupt number in raise_irq

 drivers/pci/endpoint/pci-epc-core.c | 4 ++++
 drivers/pci/of.c                    | 3 +++
 drivers/pci/pci.c                   | 2 +-
 drivers/pci/pcie/aspm.c             | 3 +++
 drivers/pci/rebar.c                 | 7 +++++++
 5 files changed, 18 insertions(+), 1 deletion(-)

---
base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985112;
	b=YtAGYejdUymTQCVHqE12QRqg0kBw4CQv9j49USUUYmMtPWabxD+xmDsx2umv4fNASgGw
	 vRZK3rNubVZKFQ/0QuaARO4M/Q4fP15FDMjLGUajHa+NcY8hN/c87FrFyIF9TP7CsE0V/
	 /qY6WYC4Qd1bBN8hBVBpJGW7JVVRRiD5pFEgzz6WPPWJW3JF/a0ZMJViZHlHF0V0+WCjB
	 DHalfny/RD+M22LpqKDqN8YpJBGqQWLHDrQQ95+bvtkGfOcroBij6gQd/poXNM8/4qszD
	 eZBQmNrK/Z1Z08a8TRWO7LwwCO5BJDG1Fjd99P5h+TcgOCW6iXPsLruKxfFB3yZ22XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985112;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=KC09ZFwwTt1laafJpmjQa1oZqrnPlGfwhuKbiRREODE=;
	b=kn61gSueorxhRW9uflKqEgecvFCNps4OxwoJsAs6aSgj1eiXZmFcmRDpX42H7dnDeYXU
	 nn6bWsTo3oyMXysSw35Q+lz0iBC3aWHEuRwPje9S26fU90kWdnf4zjwZITlsSLUSHqAqX
	 kyIbiiD4agAo18cfHPLiMN6BaFPqt33dzZhQh5ld65/3bdV1H1JWCMDAD5POvsWjK48vP
	 kA/Z60JSzgJh0zpD9iHHZRep+048DqQAAGmseKL+GsBDoM4s0yI/I1Gz0ysbiaLNG93No
	 NFjwXSLpeqwb2y3bDGWSwnJNeS0PczcOvwlxWAE/uYjpRJycx5BHxMhs+iHoDQOAk1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767C6606A326;
	Fri,  6 Nov 2026 17:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 767C6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jLm1d1yw5z8Xrr9;
	Sat, 07 Nov 2026 01:11:49 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6A6HBeV3052695;
	Sat, 7 Nov 2026 01:11:40 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 01:11:44 +0800 (CST)
X-Zmail-TransId: 2afc6aee0a50559-e44a2
X-Mailer: Zmail v1.0
Message-ID: <20261107011144094m_yk29jjckmiwGqC832qf@zte.com.cn>
In-Reply-To: <a9c36a69-a0d3-62af-e5d7-cf99c427a1ff@linux.intel.com>
References: 20261107002305850zuBaVsGBz3wbco2Ae4ScR@zte.com.cn,20261107002315181vFaB7Y_zoFugWEVkOSGJZ@zte.com.cn,a9c36a69-a0d3-62af-e5d7-cf99c427a1ff@linux.intel.com
Date: Sat, 7 Nov 2026 01:11:44 +0800 (CST)
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
To: <ilpo.jarvinen@linux.intel.com>
Cc: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, <mani@kernel.org>,
        <kwilczynski@kernel.org>, <lpieralisi@kernel.org>, <kishon@kernel.org>,
        <Frank.Li@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCA0LzVdIFBDSTogcmViYXI6IEd1YXJkIHBjaV9yZWJhcl9ieXRlc190b19zaXplKCkgYWdhaW5zdCBvdmVyZmxvdw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A6HBeV3052695
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 07 Nov 2026 01:11:49 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEE0A55.000/4jLm1d1yw5z8Xrr9

Hi Ilpo,

Thanks for the review.

> This is missing how it can be reproduced with the existing kernel code.
> If it's not triggerable, the Fixes tag should be dropped.

The only existing path I can point at is device-controlled: sriov_init()
leaves barsz[] zero for unimplemented VF BARs, and a device can point the
VF ReBAR control's BAR_IDX at such a BAR.  sriov_restore_vf_rebar_state()
then calls pci_rebar_bytes_to_size(dev->sriov->barsz[bar_idx]) with zero,
on the sriov_restore_state() path.

That is not a conforming-device path, so I understand if you don't want
to treat it as a Fixes bug.  If so, I'll drop the Fixes tag and keep the
guard as hardening.  The commit message will describe the path and the
TEST-ONLY hook honestly either way; it should have done that from the
start.

The bit-63/U64_MAX inputs are hardening: the largest valid BAR size is
128 TB, so no real resource reaches them.  I'll keep that guard but not
use it to justify Fixes.

> So no real reproducer?

No real-hardware reproducer: QEMU has no rebar model, and the hook only
calls the function directly.  It is a deterministic test for the guard,
not a path-level reproduction.

> Won't this clash with the normal return values? -EINVAL seems better
> choice.
> ...So now you get to add the error handling too.

Agreed; 0 is a valid encoding (1 MB), so returning it for invalid input
is ambiguous.  v2 will return -EINVAL and handle it at the callers:

- pci_restore_rebar_state() and sriov_restore_vf_rebar_state() write
  BAR_SIZE directly, so they will skip the BAR on -EINVAL.
- i915's _resize_bar() and xe's resize_bar() log 1 << bar_size, and
  xe_pci_rebar_resize() also calls pci_rebar_size_to_bytes(); they need
  a negative check before those shifts.
- amdgpu_device_resize_fb_bar() needs the same before using rbar_size.

pci_resize_resource() already rejects a negative size through
pci_rebar_size_supported(), but the direct register writes and log
sites above do not.

Thanks,
Shao

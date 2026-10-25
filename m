Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792970310;
	b=iGKRLY9aBSMQO1vO7N0Qx4W8Df9OQcJX28wXHU4nLmnVUJx7HFvj9sXYumqC3ZU1RK2r
	 Hiu81kkxm0xQ+eapvMKNdiWuKqn4uD9M7KDv4N9dwKnuzhpXYNK3k077ffGIFlkqvpnCG
	 nIjq34Hf6FMTT5DA4dcEleCbq5lDB0dojAwniHcEA/c6SwYr89PDuvKACpCZIs0acdCZv
	 C76HtMuivn2LOL2ocuX9CiLkMAlb+wyXo8RkRXFNmXvLp/LR1VbYw6x8ejZ8iVZ4h4lka
	 I+A0V/oxl8OtsgLIk2zgTT6j4VndBs7k7KOm9QgX9QWLtqnA2tWNIm5jX290DLa2ORg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792970310;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=IsDZuYe/u31Z24m1fo53qcD2/S0Aflbxvhhbas7bU0E=;
	b=VbJk/rFnClnZOteVyJazUOidv62BrPrO7Sj0p8duzHnXxJkLbnXZfnXyo4IEXedeC2EI
	 ZdpOS1e1Eg++Ed8czWIwGFv8YltFNB3Fm3Qz0zRX1K7UK9ehuoSgL31K+4BxEIUS+YjQc
	 ClzaP/QrOOrVkQ7c9Kr0i3UpvHQOIS643AW6S1+lcW2Qtd5rgo7IODXvM9Wf69lkLyS5P
	 upBob7U5vj7g/74DaAaFpgTWJPLNMUKOfBMrFLSJV+TsPTIOJmCFkU5GdPS75vNn5eQEi
	 8epd3XSj6IQo0JNTLcBfDLoW1a8ogTVIMxzgXaxc6uyZyZXrgld28haPMi4CWZFX8fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YKeT6MzV;
	arc=none smtp.remote-ip=95.215.58.144
Received: from mta1.migadu.com (out-144.mta1.migadu.com [95.215.58.144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18466606A31A
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 23:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18466606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YKeT6MzV
X-Envelope-To: linux-pci@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=giFcj/H5TeeaY7RoTLdlL7KXSHlcCEvpCSpIOsC9ork=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792970302; v=1; x=1793575102;
 b=YKeT6MzVWMiM10TIAp+pbD9GT3ydozIH/vyyY8c2+lgGpwjaei8W/1u1raHaF4yWVwv9cM+n
 0AUTWzCeoXfoVlKSIAIHSE/f45CkUkVRn3cyQoNT6e9v3FI5lmyEsWnpp8Nj/1FIgIZ+xQzyJ70
 q76hVH0R/2zKvgUPXVkvVXkc=
X-Envelope-To: linux-pci@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7259c9b1e57365a6;
	Sun, 25 Oct 2026 23:18:22 +0000
X-Mizu-Trace-ID: 7259c9b1e57365a6
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com,
	linux-wireless@vger.kernel.org,
	miriam.rachel.korenblit@intel.com,
	emmanuel.grumbach@intel.com,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH 0/1] PCI: Disable D3cold for Killer BE200-family WiFi on MSI Claw A1M
Date: Sun, 25 Oct 2026 23:18:12 +0000
Message-ID: <20261025231813.128649-1-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
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

Hi all,

The MSI Claw A1M is an Intel Core Ultra (Meteor Lake-H) handheld gaming
PC carrying a Killer BE1750 WiFi card (Intel BE200 silicon, PCI
8086:272b, subsystem Rivet Networks 1a56:1774) behind root port 00:1c.0.

During s2idle the platform removes auxiliary slot power from the card
(D3cold). On resume the PCIe link fails to retrain:

  pcieport 0000:00:1c.0: Data Link Layer Link Active not set in 100 msec

and the card reads back all-ones from every register: iwlwifi dumps its
complete register state as 0xffffffff and the device disappears from the
bus, so the machine has to be power-cycled. This is the resume half of
kernel Bugzilla 220223; the detection side of that bug was addressed in
commit 224476613c84 ("wifi: iwlwifi: if scratch is ~0U, consider it a
failure"), but the recovery path still does not bring the card back up.

Keeping the card in D3hot with the PCIe link in L1.2 during system sleep
(not letting it fall to D3cold) makes suspend and resume work reliably:
the card survives every cycle and NetworkManager reconnects without errors.
The SoC still reaches S0ix during the sleep; measured with pmc_core
slp_s0_residency_usec, a 241 s timed suspend accumulated 239.5s of
S0ix residency (99.4%) in this configuration, and the fix is independent
of the platform's ASPM configuration.

Patch 1 adds a DMI-scoped quirk disabling D3cold for the BE200-family
device on this board (pci_d3cold_disable()). It mirrors the workaround
distributions already ship as a udev rule for the AX200/AX210
(8086:2725), which suffers from the same class of failure; doing it in
the kernel removes the need for userspace workarounds. I kept the quirk
DMI-scoped to the Claw so that D3cold behavior is unchanged for this
card family on platforms where it works.

Testing: MSI Claw A1M, BIOS E1T41IMS.10D, kernel next-20261023. Multiple
suspend/resume cycles with an RTC-timed wake (240 s). Without the quirk
the card is lost on the first resume (all-ones register dumps, "Data
Link Layer Link Active not set in 100 msec"); with the quirk it survives
every cycle, reconnects, and d3cold_allowed remains 0 across resume.
No AER or pcieport errors are logged in the resume window.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=220223

Denis Benato (1):
  PCI: Disable D3cold for Killer BE200-family WiFi on MSI Claw A1M

 drivers/pci/quirks.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

-- 
2.55.0

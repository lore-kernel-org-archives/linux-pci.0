Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794389452;
	b=I3bn4zSKaMzY88oVNCKdGoiveT2/3k39Hfgfkhj/oHaoAmGagHJRdjUyCMNhdSxdYF5u
	 moEi41mHajBYDAgsYRr92FVgJGOujLFYJiIMtXmlUvBNMW4N08Bwgnp7e2i8+XRHyuwqY
	 sZ47D3ELc80jhf0akKwalGAyW+ACPCVQkTS7nRH3PMmjeeCfIQs/RcrUvrEQeGTerHsse
	 a3gFXsxROVUcxWS0cLjyMNuTM84shxxpTjc581CO2pKvpqZQZhIEi7ii2aK/o6/Ex5KEX
	 eEpr1ZZrEdzMJfoBNzolOs5t0NZHQCtaUe/zaJvG3pnZjRtcTuOCEUPj8ypdm+FPb7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=B3ZS/U6BiBBD5fGeH1R5VkY9NPLOvEtcvatjGhH2bZ0=;
	b=0ntwoMA56/Kr1ZjHlqo6EWwktLwCm5eA8qjckb1VpVUdbUbgR+FCV+WvVQ4GhHuxWND5
	 Tn+GUHP6mrVm+6SGV6lKM2WFsRCS3nQYlQRBvr9JDTZClp/LxlQHyzo4Wj7gnYyGcowge
	 ee7UoG935Y43PsDAnq5pS+2IRHiN54tDADEe+E/EzEzcIYJ652chlPJAGDzSVS6LyKS8y
	 K6+yKAy3MHIbfP6+3E0KhlLNtwy8nqLTucbGQm0xIb6jT3LIllGRTTfb1MfBWh9AcmXBa
	 7rr6TpKnkgptutHmSpTqL43rD9xJk3I2sw0xEsk6YcrduCDjhkrDZU+7k2Du58a4MJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bjJSDUbt;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B191B606A31C
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 09:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B191B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bjJSDUbt
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so1948104f8f.2
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 01:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794389450; x=1794994250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B3ZS/U6BiBBD5fGeH1R5VkY9NPLOvEtcvatjGhH2bZ0=;
        b=bjJSDUbtOzaOAQpSLf50C7xoz9mpqk5qHohnCIlWIv+4dIzFCWT8uBWQH1BMHIwq92
         Sp0skk7bQEZLBgS9CBlRt3NPDx8HuxaDGWyvWfkZ1t5b9SklX5+Z5vQDrp+iOrJ3CWzk
         5anlnWL/yOmkvajDxM0Sfb0kdjTXD7vcoBuTVSvmPr/cSe5SV0IKMaZEs066FbMiPLUX
         Aap9BpEE1/6enil0jBizKD5Uh6mVeY0FLVDtPivV8kKXMLwefcdUh/80Q5IJTKpbNejz
         jXcY705DjPDXEcwVQ21YLgF81sG8rxoLoWlBnl9XRE0iNOJ6xgfV2KOcCCdcTYXutmYh
         s9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794389450; x=1794994250;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B3ZS/U6BiBBD5fGeH1R5VkY9NPLOvEtcvatjGhH2bZ0=;
        b=QTSeFskLUgQTzQAMnwIhOnrK8bF3kVwfnJhvf0HEFGQO04/ktV7ZWuHEF4X4P9ZFHB
         JkdTZR4LRp4NUm+C6jY4t6jqPyY/O0oZ46aEG89xvrjUWDCejV+Gz6nYwq8eCswRY2M7
         rTjHAiI0HVHaXouMjXswBjQzTKiasP18/jXSIXxIysHXpvG/yiAogoDAlrybgdz1UmxN
         sXRcCAlC+IwR00Grjw6Kev5hdpBkZdHHAvZ7ms61NGZLvjGTVCdqDTAJTu08FVUcZfYA
         /PsTBD0RHqMZbFsJf2qdnNBGVNUaVId6WNRY2/S74KVSdUOHtMaEvoo+IxSLNwW6fOkI
         6l0A==
X-Forwarded-Encrypted: i=1; AL+hErElievEcLeU+r/by7Z7SOIBc1o3G1oiiESDTqNc4CxLoykEEEltkHlRCutPzk4iTr4EOR/lob4HdOo=@vger.kernel.org
X-Gm-Message-State: APuU4Z97CSZnOxHMVmAnAzqxTZItwvpC8VmMU8x9P2dJcw7otuCLlltU
	MGj+zb/EkzY6h7fcVDnIiLp5tx9DPdqRr7BPXMx1+CmubHpb1VlahY7S
X-Gm-Gg: AYBFou1DrFO6B8HDWtWfue1yesca9TRaF1I6/UdWtxfJsh1PWW1FGeBi30JbOzv6WX6
	mXjgrW6yUpDb3qoKDVjjcvwxgU+fStTMBgCqIIzy5fRm31zRtCfIvieZJxJCQGIp56NwBUHcavq
	L+g7cRyhOcKxeCgcO7ygj/9zZKaJLTfJIZ8pwwvyNZ0+RSduzKdMBvIz8Zs+xjDZq4R7pMFOHVR
	IEfe/qZKU1RdomMJ+79cYIk+TxoY71GedKZHA1/xQJiGf7Aml6h2ohrVOhxAX3VHl7i+Rv9Scni
	WeDWk/is2pBOh9n7mCu37e7Y/BUey4MgncDqhRammwNwSdE2FyDftS28sZjfPAb0XbcRHL+2TYj
	9/0axaWhtds+8JQ7TbJE1KUVUs3OSgAVYGV2+jjlnCaMjnK00pAmE8vg6hvFT4JbOk2kNOURxGM
	xbHWBoQnzEZKVXCJFE4K2zyK+c+s1GWNOVzKK7pBml+QHTXPbmI9vmHRTV55Wx4Q7nG1KrtawZM
	g+Ipp7pO8hx1VjxTTsb4uj557mkDXgoB4g4zPfZBb1GrKgnu9CBorNo5pn0YmHABEslE2GF5FrI
	S2P7h/ENQKhFokttVuInLYLQyiQ1U3XJ+W79qe+hMgwc7O766eRSapzTodcVUJIy4XlKV9601PU
	YAFDA7s7N4R1Su/0+3Tmxl/n7H6XM5sP5J5Ta/fiJxEu5P9OmK/bTBbr/Zz2tNDh3+Kbjdil2Z8
	+xPrfb1Lnxax4=
X-Received: by 2002:a05:6000:25ee:b0:48e:932:aefa with SMTP id ffacd0b85a97d-499c630fe5cmr2820902f8f.26.1794389449756;
        Wed, 11 Nov 2026 01:30:49 -0800 (PST)
Received: from AHERLNXVDANI01.lgs-net.com ([193.8.40.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498362eb14asm9175839f8f.34.2026.11.11.01.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 01:30:49 -0800 (PST)
From: =?UTF-8?q?Daniel=20Via=C3=B1o?= <danividanivi@gmail.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	dima.ruinskiy@intel.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Daniel=20Via=C3=B1o?= <danividanivi@gmail.com>
Subject: [PATCH iwl-net v2 0/2] igc: fix L1.2 disable on resume, add I226-LMvP to I226 helper
Date: Wed, 11 Nov 2026 10:30:33 +0100
Message-ID: <20261111093035.513635-1-danividanivi@gmail.com>
X-Mailer: git-send-email 2.53.0
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
Content-Transfer-Encoding: 8bit

This series replaces "igc: Disable PCIe L1.2 substate on I225-LMvP and
I226-LMvP devices" [1], split up as suggested by Dima Ruinskiy.

Patch 1 removes pci_disable_link_state() from __igc_resume(). That
function is also the runtime resume callback and can be reached with
pci_bus_sem already held for read (pcie_do_recovery() runtime-resumes
the affected devices from within pci_walk_bus()), so taking the lock
again risks a deadlock. The L1.2 disable done in probe persists in the
link's aspm_disable mask, so the call is not needed on resume.

Patch 2 adds the missing IGC_DEV_ID_I226_LMVP to igc_is_device_id_i226().
Besides the L1.2 disable, this also moves I226-LMvP onto the I226 TSN
code paths; Dima confirmed that this is correct for 0x5503 [2]. Patch 1
comes first so that I226-LMvP never picks up the problematic
resume-path call.

The I225-LMvP part of v1 is dropped. On the setup where I saw the
errors (HP Thunderbolt Dock G4), the I225-LMvP does not advertise L1.2
and the upstream port has no L1 PM Substates capability, so L1.2 is not
the cause; I will investigate that separately. As agreed with Dima
[2], disabling L1.2 unconditionally is not part of this series.

Testing: compile-tested only (igc builds cleanly with W=1). I have no
I226 hardware, so neither change has been runtime-tested on the
affected devices; testing on I226 / I226-LMvP would be appreciated.

The resume-path issue was reported by the Sashiko AI review of v1.
I used an AI coding assistant (Claude) to help with the locking
analysis and to draft the patches; I have reviewed them, compile-tested
them and take responsibility for them.

Changes in v2:
- Split v1 into separate patches, as suggested by Dima.
- Dropped the I225-LMvP L1.2 disable: L1.2 is not supported on that
  link, so it cannot explain the dock errors.
- New patch 1: stop calling pci_disable_link_state() from
  __igc_resume() (reported by Sashiko).
- Corrected the Fixes: tags.
- Changed the subject prefix to iwl-net.

[1] https://lore.kernel.org/all/20260925112850.189302-1-danividanivi@gmail.com/
[2] https://lore.kernel.org/all/5d45a583-198c-467d-afbe-8f19398e82f3@intel.com/

Daniel Viaño (2):
  igc: don't disable ASPM L1.2 from __igc_resume()
  igc: treat I226-LMvP as an I226 device

 drivers/net/ethernet/intel/igc/igc_base.c | 1 +
 drivers/net/ethernet/intel/igc/igc_main.c | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

-- 
2.53.0


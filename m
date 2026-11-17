Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914310;
	b=HAjvtdEk2oyuKHTFmt9PX02bMc/w6O+v88jr+4+4awAyReaPlm8UobXKDYOCHq1dzRhC
	 8eYSLH741I8hpi9EZ8Mi4mCebg8MBY/YD5EO4fNtr+NG/4WRitQHUCS2HN3k6VJ+wdjQz
	 GFsFcEcrioJxSQj++c7NKJBWanRnlwNTiPbz1owyqasWLx0svKr+rR4dG/RnuqjbEo7Vl
	 HKiV+mfs9t05cQRVZml/Hp1RHMAPPItxJk0cGYUsguPUxllM7V+/R5qjbIGf55j87fcaY
	 HA5/Rbye0qe1GgMw3UvWRwinTzK0EpApXCAMBr8K6e/XcFF69WnchkBJZae2UHo5WdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914310;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JBdBGYVRxNYOJdT2394qct33hCcjoUXwpWM/aTSPVhs=;
	b=xrTS/ArbZbHvawQRZuLoAQN/9Ac97Zo17w9Akp+E3WapaLLf27B2VRimL3Aqd5hRp1H3
	 ZRACn/MaOJ4Y96zV1RgWCDmvWOagnrbOc18QKphFRstsRMbvS4VQ3Rc4B9nz7XCBfEhDg
	 lOmdHc+kRQRFTejyOcYgg8Kx4+wD5cX40PpAJbtK941/MDYhcFjwZa8edYkPBz/O+pRHu
	 4wDMFOe9a/LwNWhO55BwO0q/Ssh13nAs3l4KG9o14IbKJN/O6ZmYvEwmwNYTJMVXCZPGH
	 jh3sEChtK6xoKEPUX2krJnVknYThu890IjXDPowJWtelkL5y3489Vk3YtZ3Gr//cV2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=R1St63Gq;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64D3606A323;
	Tue, 17 Nov 2026 11:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E64D3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=R1St63Gq
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AFD41BD0;
	Tue, 17 Nov 2026 03:18:26 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5F6413F763;
	Tue, 17 Nov 2026 03:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914309; bh=Pk6YrAE/nTxDcvg8Hm+R5p8sZab+WMj8uqsEYyAJctY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R1St63GqI5kTgA9jTyvQVN61vkTHDA+4ypR44INnVvGa7bkEC1LsO5i/DFwnOHLwr
	 hxTscmTwbf9li29BlibU0B5NIYF/tH73sL3pv5tdT8MCK0ksLYcYlMnWppK/NBW6hH
	 z7I7rbwM8EN022PRX03/5Vg8Q80KI4fBgqMgg4Wc=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>,
	James Morse <james.morse@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Dan Williams <djbw@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v1 09/19] ACPI: extlog: Report errors independently of RAS consumers
Date: Tue, 17 Nov 2026 12:10:19 +0100
Message-ID: <20261117111444.4185512-10-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117111444.4185512-1-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
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

The RAS consumer check removes:
- trace events when no daemon is registered
- CPER console report when one is registered
This ties tracing, PCIe recovery and CXL protocol delivery to daemon
registration, and can hide a fatal record when userspace cannot process
its trace event before a reset.

Remove the RAS consumer registration condition and:
- always emit trace events
- print the CPER record only for CPER_SEV_FATAL

[1] additionally suggested to have a cmdline parameter to dynamically
update the above policy. Keep a simple hard coded policy for now.

[1]
https://lore.kernel.org/lkml/20240521183913.GGZkzqUSN1hdE-_OEY@fat_crate.local/

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/acpi_extlog.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index e09ea571c32f5..16a16b12d8ccf 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -208,10 +208,9 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 	if (cper_estatus_len(tmp) > ELOG_ENTRY_LEN || cper_estatus_check(tmp))
 		return NOTIFY_DONE;
 
-	if (!ras_userspace_consumers()) {
+	/* Print fatal records regardless of RAS consumer registration. */
+	if (tmp->error_severity == CPER_SEV_FATAL)
 		print_extlog_rcd(NULL, tmp, cpu);
-		goto out;
-	}
 
 	/* log event via trace */
 	err_seq++;
@@ -255,7 +254,6 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 		}
 	}
 
-out:
 	mce->kflags |= MCE_HANDLED_EXTLOG;
 	return NOTIFY_OK;
 }
-- 
2.43.0


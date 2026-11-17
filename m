Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914193;
	b=4Km0zHSWq8l89Ia+LXgUGGJEjoHaLgk5i6mSFew24XXSd2xPafh19DRfu/5noj4dxgWc
	 qK1f5pPVw4hWUAOlZ43lA/DdzjdghHt6DjXrTQ9oECIQCFX68bGpecjlWpf8GC2PVTadu
	 Uu8QQuWcQyEeqeeNn/tVqwnYhS4zl9qAt5fwlJ9Gqwu5Zztp+wedBU0d3mWMsFGg7xPaS
	 vLmjq4Y5ZQ70ovsgLRjStGockdLBsDhL4nUyMI8PnZ+217y2+mXvM+476CCbvN24MKGxo
	 wbrEMr11SUuLyJt3e9JN6KIVOHkmSjT39A4PK4wRv/P6M8rsJnguBP/R11fKe9vzvpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914193;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=G2N13G5utyTe7izqnWDvvwrQ2fOwakujOweKmNqrGrA=;
	b=s9M2XfaOZBuezNgok1mkisVa094Uau0HiLoQGsXWtRoSQbvhvQ0w3PALF68m6Qcziq/B
	 02Kv+ovLhrtY3VXQa6gA2FfPnUNZxkRmWyRPvDhwlwucwJEdHu4xC5DqowQk3z33COwur
	 dQANaA4s34rgi3qcj0ZUzQ87VdbAlLpWOURMQ3mj9pWGhhPJ193OOEwfyqmlKyMf/qgrD
	 KnJ29c6cAH+icK2kGQ7D2d85hNbQ0hXhmHgBqIHygqQlgTPHlJr4oq/6NmaDSCEbL2fLm
	 13zG98LmL2Lr8AXcumbQgeD3lQMQvz5qbd0rS5I+mtNdwn4J0KVsfYTLWbAm84res1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UE0kJdzu;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799AF606A323;
	Tue, 17 Nov 2026 11:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 799AF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UE0kJdzu
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E28441682;
	Tue, 17 Nov 2026 03:16:28 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0A46E3F763;
	Tue, 17 Nov 2026 03:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914191; bh=nQ/pGewZ6c/kd9JIrH7S2KTGuPSpp1O8X6Rcs0KcnQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UE0kJdzuB5u+54VYGkLHh9IxD6zwtneuQSgzckgRUphS2F6ekg0cdSJG4nhoBtzyj
	 eVdZ3PQcTpnwHS/ywvKtG7aSuAIbf9QXDXq3ei3yhCzJcRN9Ig9Bdk8ebrsbSfPjYZ
	 9WkL0MWcxwOgbX0INOdI6xO0+nf5fQKsj4viqusA=
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
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Dan Williams <djbw@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v1 03/19] ras: Bound CPER FRU strings in trace events
Date: Tue, 17 Nov 2026 12:10:13 +0100
Message-ID: <20261117111444.4185512-4-pierre.gondois@arm.com>
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

CPER FRU text occupies a fixed 20-byte field and need not contain a NUL
terminator. Using __string() can read past the field and, for a short
nonstandard section, past the end of the firmware record.

Bound FRU text in the legacy memory and nonstandard trace events with
__string_len() and strnlen(), as already done for the Section 2 event.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 include/ras/ras_event.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index ce759ee1cf4cc..069c7b3a5e6c0 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -39,7 +39,7 @@ TRACE_EVENT(extlog_mem_event,
 		__field(u64, pa)
 		__field(u8, pa_mask_lsb)
 		__field_struct(guid_t, fru_id)
-		__string(fru_text, fru_text)
+		__string_len(fru_text, fru_text, strnlen(fru_text, 20))
 		__field_struct(struct cper_mem_err_compact, data)
 	),
 
@@ -370,7 +370,7 @@ TRACE_EVENT(non_standard_event,
 	TP_STRUCT__entry(
 		__array(char, sec_type, UUID_SIZE)
 		__array(char, fru_id, UUID_SIZE)
-		__string(fru_text, fru_text)
+		__string_len(fru_text, fru_text, strnlen(fru_text, 20))
 		__field(u8, sev)
 		__field(u32, len)
 		__dynamic_array(u8, buf, len)
-- 
2.43.0


Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EFC3AE1AD
	for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 23:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774310358; cv=none; b=WuoTfeVbSX0OKzk3aAb4uIus9ZPALex7tymKkAoscd44wBIFZh1UGYt67MR2yp9vUt3+gl9IDUnaf9u94Eq/Q7XCqjiT5XKg6DF8DBso2JO6j513eNPOk520i6AM3PMoTLhPPGY7A84h0s+kMUc1/xcRW1xN2214qOalYjd+YdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774310358; c=relaxed/simple;
	bh=WyJEus1uJnXy8m0ACloG+/0RKFyldGkXc9VBNsLAa5g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XO0ngViBU+wvx0QE9bNE7sayRTSJtgDyXE2qudo9aes3IR+UHs9dkHxrKX/gPqTtyzBWowYOLPiQHQ00HrcLstWWh4yjZgoES0aOdLqgBqV1iCNmRhvnEbV+LzRrlF/Cm3TGAmNckN7p12rTDgdAwCcwxWKuuxqhJibVsyiYkIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ajyUNY48; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ajyUNY48"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35449510446so773116a91.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 16:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310355; x=1774915155; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CreqaGlwQEQK+YRyK6iGxzdx6WSNNVSy3f0PqjRZciY=;
        b=ajyUNY48YtupU10DQPf/1QAF7odcTf4OF8sqdhpBiGvFQLNJH9cTPvJZtO1s1753Pv
         MA6FnBthhJ1bbcJ9DEcL1fHOVJYpURhQf9RnV9nBBEtOw2q7JJalwEzS5KJBw5i9G1bv
         wH9kkAB42BSECyvkJuWH1d0ZrBE7IA+LhG4IV0Qsnt9At1aianoU9jmO2LEDq0TXFV63
         WmhdKVW+Ug3oPAFbJ56TUEtM9ayhjVwxySBQS6Lb7all80wZ/2FkD4NIKRMaAAk8nsZh
         jfl2Q+dkxavhG/jk/LI0A0YlzDaIYKs5arvXLkRi308kvupxkiG9jWawFCjaYa9vO7Oy
         +Bgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310355; x=1774915155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CreqaGlwQEQK+YRyK6iGxzdx6WSNNVSy3f0PqjRZciY=;
        b=IiaEWRs3f2yQe7WkjV7UNLjqcb/y/yTR/jESeGjjsCpB8k/I6sbWPznbuFAo+ct6/k
         KAhfeOuGWBzby9CTdt55XgM4tW2mAFkP5anSrhTzEkk6Z6UuUtBOfjFsoRjL4Xuede7y
         UHxVScyTJNh/QgfWgqSy0WX0vfp3O+NQn0oxzQDzs9u9wGZe2vO+xQIcdixMNcmjMHMr
         6XhceXwKzl3pqwpZxPteZoCoID5PPvat4RSXGjjR7dn4//L5SItQqaDVkCtsefnBPVf3
         qm5MWdFJOI3LnDN7/1vtIdCY6w4zhG18AB8wxyq5QJMd+xtZ6Gl6z877ngbM07UEj+Ah
         uZLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWoSOWM7fAuvUwAHvHVTjXWFREoE4GCd2ObkLg84CnBqUWPVgnLoxPE1qgutLWsIXasWj/FHwk4t8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjc1bEfTRFXLtO99H90ntcWNo7ibXuv0x2w7LLf64ZN8QQ72M5
	2xkFCo2cbo+YP4cugU0yQgosDJn5zCRILX/nrqC9lIJQlnbAmlDoyhBcv1259IJBVVs83BnqCTT
	CNBIi4bUQe2+5CQ==
X-Received: from pjat16.prod.google.com ([2002:a17:90a:d10:b0:35b:a2ad:add2])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3d85:b0:359:1063:6aed with SMTP id 98e67ed59e1d1-35bd2cb3e52mr11055132a91.22.1774310354638;
 Mon, 23 Mar 2026 16:59:14 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:58:13 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-22-dmatlack@google.com>
Subject: [PATCH v3 21/24] vfio: selftests: Expose iommu_modes to tests
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Feng Tang <feng.tang@linux.alibaba.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Li RongQing <lirongqing@baidu.com>, Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Expose the list of iommu_modes to enable tests that want to iterate
through all possible iommu modes.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/lib/include/libvfio/iommu.h | 2 ++
 tools/testing/selftests/vfio/lib/iommu.c                 | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
index e9a3386a4719..4b9cbe262159 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
@@ -15,6 +15,8 @@ struct iommu_mode {
 	unsigned long iommu_type;
 };
 
+extern const struct iommu_mode iommu_modes[];
+extern const int nr_iommu_modes;
 extern const char *default_iommu_mode;
 
 struct dma_region {
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index 035dac069d60..95a494f829d2 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -23,7 +23,7 @@
 const char *default_iommu_mode = MODE_IOMMUFD;
 
 /* Reminder: Keep in sync with FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(). */
-static const struct iommu_mode iommu_modes[] = {
+const struct iommu_mode iommu_modes[] = {
 	{
 		.name = MODE_VFIO_TYPE1_IOMMU,
 		.container_path = "/dev/vfio/vfio",
@@ -49,6 +49,8 @@ static const struct iommu_mode iommu_modes[] = {
 	},
 };
 
+const int nr_iommu_modes = ARRAY_SIZE(iommu_modes);
+
 static const struct iommu_mode *lookup_iommu_mode(const char *iommu_mode)
 {
 	int i;
-- 
2.53.0.983.g0bb29b3bc5-goog


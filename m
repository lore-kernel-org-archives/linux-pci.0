Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26F836681A
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 21:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769721964; cv=none; b=Wotmx8EtgplKm6A8cfrG/CdgTgqTZOIsV/HYKV0iOOvrZCkTLm/MTg0XT7oeogeCHL1kNi/TN7AR2uqN7k8vZpkVfZWGEvcN8F+r9KST8rKwtqln0X3oPTECfVFI4ZWTyJepj3OKR1TV37R/v+KnSt5y0azA/3+HfiX4ZJ2kd3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769721964; c=relaxed/simple;
	bh=Cb9Y8KWzYaZZbnWLogkDgrwZwr7o6CbuJ0QS3Pv10oU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e7dftvPex+t+GqYivi+DcUesGuovk7hLTbooAGXYFUNwWjseNbT7s66H5VnMzXErvl123/4YErbtW7CmAdbGxce3s5X9z9AGFrvw7wIL4YG7qu9PyV844l0jr41wfyYEAXhXru7oDJY5r39W3l8keOU4f+br8WZLezoR7Ilzikg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y1MvxdcS; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y1MvxdcS"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a0f4822f77so38209115ad.2
        for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 13:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769721962; x=1770326762; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BqEhbyqURPyKNgE6Ne2XGuBboHLh1jY5l9yG8cIgxTg=;
        b=y1MvxdcSHAA2tv1IsyzFmRw57KM/wXj1R1ZdYWaSIzlN1RSmx2DZC/lY7CimLxCBCS
         0vK9SoPcz8XrCFytWn1qKRZdDSdeZ2t6R/Z91DQq/Tpgpc7vbc8pNHwoXbibrUy4JtUd
         XRvw/ZkDVaWbdWDB8xoDlo+9pCWweFVIIAB9EwHkW1wCjh98cRA9acf88FsvMfg6F7V4
         eOA4JZ1Xwkh9rCClweXAF4K4BDHCeLPr55MISxcyzWjgfkaiXXuW4QyrTxZChFoFlnTe
         u8lC+qyEk85GD92i475reauTgqevO+KpL/a6ENkj51ChBaphwulFIdpnaq0r957wLCDr
         8FGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769721962; x=1770326762;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BqEhbyqURPyKNgE6Ne2XGuBboHLh1jY5l9yG8cIgxTg=;
        b=hsJ9gEu9PkBaASrLM9FhYKGm/IroLZtdQ7Nx3j4vfaSQBFsMX5O/pzYkBt9gwKA6MX
         htsKoQ9hig6E9xR0D5XAFxISYhKbm4a5Mf2E1fsy25xE1ly1xcXluqqWncUevtRLLh6d
         S1NY/y8ZBsAfMSWZ/iPrK8P+6J8eHEgZqahL+pRtF32B11Yoi8DK7qI+4qmK8fDYMKJ4
         YsRy5M2Q/gKHK9xUx90UVCPVmmdgnmsC4DMoqKTa0laDL9aq7VDmwoDh1eSCpuARTqai
         pSQk49itdN66pU0HQf6swDhAA0V7DLTGJzVSy9FLAFfIqU5j8fjZ/qc1R3rEKsC+tDM4
         p1iA==
X-Forwarded-Encrypted: i=1; AJvYcCXcNxRtwsqXT0eFCZtYYhqZw9C4k6fLfVBn5KQhkskIxYebHcwX8hSsRsh3z7CPw+DZqhwKN9SQc1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTFXMTiz7FwNmwygEwgfW2rL/u3y7RoSdRlmk5o/nJf+0JnjHs
	Q//h3rPzrVr3dFNDEe1r+U18k/tXfPI8P1s8CIk2FYzhcGH8ghq9Inha2g3nKJD3PIYZYCJ1bon
	K3MTc1IEKBaxOSA==
X-Received: from plot3.prod.google.com ([2002:a17:902:8c83:b0:2a7:78b9:f962])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:bd03:b0:2a7:a9b8:ebb0 with SMTP id d9443c01a7336-2a8d96a7ff3mr3875585ad.19.1769721962280;
 Thu, 29 Jan 2026 13:26:02 -0800 (PST)
Date: Thu, 29 Jan 2026 21:25:02 +0000
In-Reply-To: <20260129212510.967611-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129212510.967611-16-dmatlack@google.com>
Subject: [PATCH v2 15/22] vfio: selftests: Add Makefile support for TEST_GEN_PROGS_EXTENDED
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	"=?UTF-8?q?Thomas=20Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vipin Sharma <vipinsh@google.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Add Makefile support for TEST_GEN_PROGS_EXTENDED targets. These tests
are not run by default.

TEST_GEN_PROGS_EXTENDED will be used for Live Update selftests in
subsequent commits. These selftests must be run manually because they
require the user/runner to perform additional actions, such as kexec,
during the test.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 1e50998529fd..f9c040094d4a 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -23,12 +23,15 @@ LDFLAGS += -pthread
 LIBS_O := $(LIBVFIO_O)
 LIBS_O += $(LIBLIVEUPDATE_O)
 
-$(TEST_GEN_PROGS): %: %.o $(LIBS_O)
+$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): %: %.o $(LIBS_O)
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBS_O) $(LDLIBS) -o $@
 
-TEST_GEN_PROGS_O = $(patsubst %, %.o, $(TEST_GEN_PROGS))
-TEST_DEP_FILES := $(patsubst %.o, %.d, $(TEST_GEN_PROGS_O))
+TESTS_O := $(patsubst %, %.o, $(TEST_GEN_PROGS))
+TESTS_O += $(patsubst %, %.o, $(TEST_GEN_PROGS_EXTENDED))
+
+TEST_DEP_FILES := $(patsubst %.o, %.d, $(TESTS_O))
 TEST_DEP_FILES += $(patsubst %.o, %.d, $(LIBS_O))
 -include $(TEST_DEP_FILES)
 
-EXTRA_CLEAN += $(TEST_GEN_PROGS_O) $(TEST_DEP_FILES)
+EXTRA_CLEAN += $(TESTS_O)
+EXTRA_CLEAN += $(TEST_DEP_FILES)
-- 
2.53.0.rc1.225.gd81095ad13-goog


Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360073914E0
	for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 23:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774310352; cv=none; b=N66xByqMmQe7wfsgpSFQBwGPkrwmJf6W1lxHy3JfJASNKIJaveAt/HXGlV6KPLJjVFfAahImKOXdtuoTGcgOydue/InBHh9FhBE1KJG0zL7zmTzz2jVoD0WHRoMKSFK6OYTTZ9JcceXyADAQdAxYxJCpawdiphjoo8+epFZaxV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774310352; c=relaxed/simple;
	bh=W7eZwT9DvKJLgaaduhhOROtuKExMtdW5rdefHIwBCqg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ljyqb6Y0dqlwiMqkSEKcwfANYncoRdpn8qGOcqsuNXuPlmbDkLAjwVsmL9WbeB3Q7vYIU5MHTmU/FjdFaPkNaYWzhEkqussn4jVvrHRDToq39ELMS3MJcsaMIZ1ojYDwdU0dp/5k+SfCoo7ZNVFOTTeDNx8J6sLZp5PaaVgSYBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ACki2pio; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ACki2pio"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35b977ffbcdso744525a91.3
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 16:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310348; x=1774915148; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7enZU/vxLy/6ohUczG3HchuR4oREBV6X1oYMwMHYNIE=;
        b=ACki2pioHscddV/iJdsmploffmaE3aze8hj1+YgUKEGvf6eB2GnMzQlOUvvRWQHxMc
         +4bbK1vGmBiC7mKl6GgWk8B7kcvVI175RPyClQ9hOf9nS63znMFtB4jloSwEo/h1WgNl
         X2HAQRVgjuJMPkKMUt5InIcuyfPalXMljz6NpD+zy/DqFWzTQzkVk8caICEyY7QIVMvX
         pn3kPWZCLgOMaEhCZKkRdiB7xTBIoP1MXTSMR3iJD36iRpXYTtBiRNhVuVmArPiOAphy
         4VkQyL+uUrJKBFGSM+2NpVHasdGAj4qQdJzS8M6FpAOvPcn5oHU39kiP6hWpcUzE8sUh
         tqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310348; x=1774915148;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7enZU/vxLy/6ohUczG3HchuR4oREBV6X1oYMwMHYNIE=;
        b=CifKMeAiytzOwKxRI2AT9mlZvjmxk0g8cdzfN8k0fIr6cufwnkrpyYEc3NlB1rQQK+
         ym3WcWEo5P9fsj5niIahtOX7m/RdgGHK5Sks6yPlTVjCgRB/XfVXl36yOZrfGNBuhbi+
         lsI6vtySVc8cCWNbN4lUbdWsGJ4rg6dT22+XU13gwHCJNHZ1cm0FkdjV6rcaY6QlerF7
         6QeYE/YAYo7Pow6zLFZBf0ZEUufHw/bbmMdlheWSbBCRg4NfF5SFkZxNpyrY25/Z6RQb
         JHTtCfsH8FMLL4ovB9PlESZewLVVU47oI9yFxcQ+57UB/5JuXzR6hhow5ipES8UyXPQU
         zSdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXweK6JQ2bqlkDkawhuGg4eojsEEWb0s40m7kJCitZ0n1gq8oM0ekS0iMrx5Y2LxVb3gsPDAuyLa5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGfMqanz17No3Y3TzndVkwc7fZEzvvVYGJEa8mbkHuUISeGMzu
	C4+++waB4nZBKQMOb4fKtI3I3x0ePIoTL+aeYWDxtjIOavYg24TcS+v5vaQjaC2uYbBXddI7gR9
	vQQs/Tqx6Q7FMUg==
X-Received: from pgbdo13.prod.google.com ([2002:a05:6a02:e8d:b0:bac:6acd:8182])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6a15:b0:398:7855:1596 with SMTP id adf61e73a8af0-39bcea6ed94mr12817264637.10.1774310347510;
 Mon, 23 Mar 2026 16:59:07 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:58:09 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-18-dmatlack@google.com>
Subject: [PATCH v3 17/24] vfio: selftests: Add Makefile support for TEST_GEN_PROGS_EXTENDED
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
index 7f3c94da289d..9d5e390a61b7 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -31,14 +31,17 @@ LDFLAGS += -pthread
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
 
 endif
-- 
2.53.0.983.g0bb29b3bc5-goog


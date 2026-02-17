Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EB128C006;
	Tue, 17 Feb 2026 21:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771363699; cv=none; b=CuYuI1Viq6d1A3bGoogQZBYW7uETAZxQDQirY4f/RU3FO8HgyQ+24IW2I3pTKyJB795lMH7ZFRRjnqlBbhX6wj4A9sVY160rQG5Bgq2IpyabN6STcBXM4euWwridZdC+uWDEXGG1EsTtPyDx4wmgLUmXypFENn1DlYwLP1WPelc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771363699; c=relaxed/simple;
	bh=nnaSOXUhEMnoiT7VMBqeLHc/VodZYBzE9r2yIRwoPEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jqci3hGIKur3TMLeWoHW4vJDcqCQWpKLRLOyPb08vCeMYNSrs1Mo4OLX6Tx8ph7Xv3fxOyY6epdiWBKqyF5FOQHoQ968R12Oi9x9o0+u+/ct23YlR/j1iBd5y3nZNbyZa+9GrITtTnd4XXTMTMnh9FVBhdAW9eX0TgCpSVGkg9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgSDje2O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgSDje2O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0DAC19421;
	Tue, 17 Feb 2026 21:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771363699;
	bh=nnaSOXUhEMnoiT7VMBqeLHc/VodZYBzE9r2yIRwoPEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UgSDje2ODtZk0cjpIuHkE3g1tB1fzYyR8MUkNHIpRWXSn4wW+y7JPOISjGdtYDrPi
	 8qXqMghFK0t1UD6QBwZQfADUE4iaTiQ5Dx965l1u3kBkQ9lZw+K5LC1byJwGPupyWC
	 d6A1P65CiBmAlFydN8NacN/uVIQWBNwo2/uJ3tarU7nkK7jhGsNfzXy04F2D8tXw2f
	 kGy0lR2BzCc8k6a9hRfaZWLKDGZzeK3qg9w7K0ob+fu/zTYiG/hFmQsKWQjYZU4Jes
	 sd7ydaC4fXRGoyPmmH+9emxyDkQR5liTiygyZOBo5Ll/t62ljPdzHW6yNnNrDv/jGO
	 g63s0pHW7TyPg==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 9/9] selftests: pci_endpoint: Skip reserved BARs
Date: Tue, 17 Feb 2026 22:27:15 +0100
Message-ID: <20260217212707.2450423-20-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217212707.2450423-11-cassel@kernel.org>
References: <20260217212707.2450423-11-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1302; i=cassel@kernel.org; h=from:subject; bh=nnaSOXUhEMnoiT7VMBqeLHc/VodZYBzE9r2yIRwoPEg=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKn3DU8vL7nWBpn5fnzMnZmbg391Q6XJ4rmtgnb2Xsmq tVXuD7uKGVhEONikBVTZPH94bK/uNt9ynHFOzYwc1iZQIYwcHEKwES2TWJk2PZvuv+sh6kfjh7r yt4p9vPRkaa2+rk87+TuPJXRquHmZGJkmHfzG3eM+QP2hcu83m/dYudhIDV1o//tZukkI13ngGu 3+AA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Running a test against a reserved BAR will result in the pci-epf-test
driver returning -ENOBUFS.

Make sure that the pci_endpoint_test selftest will return skip instead of
failure or success for reserved BARs.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
index eecb776c33af..e506359cdded 100644
--- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
+++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
@@ -67,6 +67,8 @@ TEST_F(pci_ep_bar, BAR_TEST)
 	pci_ep_ioctl(PCITEST_BAR, variant->barno);
 	if (ret == -ENODATA)
 		SKIP(return, "BAR is disabled");
+	if (ret == -ENOBUFS)
+		SKIP(return, "BAR is reserved");
 	EXPECT_FALSE(ret) TH_LOG("Test failed for BAR%d", variant->barno);
 }
 
@@ -84,6 +86,8 @@ TEST_F(pci_ep_bar, BAR_SUBRANGE_TEST)
 		SKIP(return, "BAR is test register space");
 	if (ret == -EOPNOTSUPP)
 		SKIP(return, "Subrange map is not supported");
+	if (ret == -ENOBUFS)
+		SKIP(return, "BAR is reserved");
 	EXPECT_FALSE(ret) TH_LOG("Test failed for BAR%d", variant->barno);
 }
 
-- 
2.53.0


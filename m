Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B023D9028;
	Wed, 25 Feb 2026 17:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039074; cv=none; b=pFKbA1MIJyKWf/CJuCEqs9XsErzRHQ8F4p0BOKJOYyB5hyX0YtHvNhXJH6pgKvYB7m/JIFeX4w2Khxuf+uOUBtqdVJCSfmWqa9G+k9oqMEvJZxpGDv4RCG5l5RcFtooh6jVQI6uRzlUpA+t+s6ae+S0UMcMPhCozpJmyCXAj/0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039074; c=relaxed/simple;
	bh=53FcLkV+ZkJ/yX06vd2deFHWSEg4zBqXXdBKAGhEsXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqXBdOBJzclroj67shns2XyWockq8IVU3qJxYTnO8/tsdGK5fviwf7uNqYrhWM9AVUF/FFFAClxbALeHCAK2LTCUZnq7dnQrsf2Zm9+c1SNSGt9FQi6yFWl1kJvjqVg4Ey5yb40+mdwyPyo3RcH3Q8FdbQEDtY68zdUdMCzzMaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Py9QMzMJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Py9QMzMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74102C116D0;
	Wed, 25 Feb 2026 17:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772039073;
	bh=53FcLkV+ZkJ/yX06vd2deFHWSEg4zBqXXdBKAGhEsXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Py9QMzMJQ6mGEHt9pK5EzR9WySbgGGOu/Ou6vUs42G4uvZ6s5FviTHsnUH7C/bGw7
	 qoyIf33vzdZGhNZgqP6aufUn1hww2qR8imUr9af7JXRWsdc9sE9z9dHWjtDjh/qa9V
	 C2zTEvvyeANch31GQFMJW7Y0xDcFmIwsACLZKGEu9l95rf74ZalI84+pXZ8OBkkrS0
	 MhnGSbmTSj21xiAEAsbXcCLwz3+s248d7+IAtEzP3t1cedwXH77W+NeZnm+TZdrYDY
	 l+UVV6OfCXbxKdTF4tBSU2sGmIj4Rt6BZHNxugETs2GiDTCOtofcTu7Qmt/BCUawiV
	 VEWBgF40BSToQ==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 9/9] selftests: pci_endpoint: Skip reserved BARs
Date: Wed, 25 Feb 2026 18:03:32 +0100
Message-ID: <20260225170324.4033466-20-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225170324.4033466-11-cassel@kernel.org>
References: <20260225170324.4033466-11-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1462; i=cassel@kernel.org; h=from:subject; bh=53FcLkV+ZkJ/yX06vd2deFHWSEg4zBqXXdBKAGhEsXQ=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDLna6c1mSxdlHl+6cn8uSczf141PPU8bufTElem1P0X7 RQ3595d1VHKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJ3FjE8M+C17tQOTVzvq74 rievf4S41T2Om+gouXfDH8XpQlIim7czMizhnf9lU7a5ecdlTWXLO4t5I03fzmu7Ym1smdL95LT 9QTYA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Running a test against a reserved BAR will result in the pci-epf-test
driver returning -ENOBUFS.

Make sure that the pci_endpoint_test selftest will return skip instead of
failure or success for reserved BARs.

Tested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
index e0dbbb2af8c7..c417fb3a198b 100644
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


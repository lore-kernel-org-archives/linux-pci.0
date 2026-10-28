Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203375;
	b=nFqcP1upMmd1vSO92A0m1IMEpDlaJHLhYULWBL955HIoZioBzTT50r9JdLh4IH4VoL0a
	 bHJw9BTcb95lTe2vCxENgOjxErwXCCippBDfRMFndgyqCBFDMpjP7V9+bjTxX6Iz/vIyA
	 RlQY31jRjAYONIPMCMljW2rQ73DZmdK09hXW726lOQjfiWmU1BbPtCeTcGvC9gBzvZ1bh
	 RF7YvqiNHD9WeMJRQ0oxIunpeS+LY8RVvtFA43JsOz3K7xxrDfIFtFG8Q3WvMjyIzzA88
	 yrypL3quuLwDDNxL9vtbHMKSRAnatnV9zRPxHQs7L1uNelqptDXG6ZBOksvYKirhKEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203375;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=wKs3vJN4ZKJpeX5LXglj/FvmPaj4cVCU3oClZIx8D0c=;
	b=iSpS5B/FnH5DfoBIpsNU0sRrIZ6kj+nQERaRjNKxeGV0ylHrtBHw7aGwO2i9l+3uDzMl
	 XjQ+3MewuSdeqtRveEG3Mbz1uCL+tODi2cp3t9iDmgbQ5+9kzygvbu1UH9g/v+Ru8F+QH
	 Ra4EytSfvacPJqxU5UtV8A61OGJrvOYNRjVsCj6qLqZbACpHXBpYFO/QjLAmKDKOSCsJ4
	 B3mYZu6xOZuQU1Rc7aMbR2slVULVd/FkvKyGFD4XIfeUsFh/N4frePw1EXQw0LTzNXVt+
	 af647X1yPkgfIEyr0WoqbR5j3WvjY+6pPbUkR5ODBONpIRqg6U0+fP/X+faHoJUo87g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=michaelburch.net;
	spf=pass smtp.mailfrom=michaelburch.net;
	arc=none smtp.remote-ip=79.135.106.113
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCA8606A31D
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 16:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBCA8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=michaelburch.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelburch.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michaelburch.net;
	s=protonmail; t=1793203370; x=1793462570;
	bh=wKs3vJN4ZKJpeX5LXglj/FvmPaj4cVCU3oClZIx8D0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Jt4sLcnfHw2wqjq78XGZQKUE3kF6VJbqSCvrO9nhkfFZNTCElSapRkr3tmLid51p/
	 42O2O4HYmn8Wgs45QxT5eMbBKDl1CiZDXRJcm7D5ZE8wVcIGug1NCaJfBg3fg0sjDO
	 XwN+uAE21c1rg7POSH5JUzepdIBq+kkjWxUj/fn0o+LUJfBb+H0eCc4l3V+i5gP4Ao
	 9UEprSoRMQXApBL0mdftZkPVFU9YnKHN1uS/ZgX74YARA1WMvuoUe+ZqqdKDrJs20x
	 zn5KEmXXR/z4ajmSKenJG8DLAhyxrfYX9/L8xHcbb25QjJJyJtEtPZEui0Dwdj80Fc
	 DDKZ2nMWelV0A==
X-Pm-Submission-Id: 4jFBw52kD8z2ScPp
From: Michael Burch <me@michaelburch.net>
To: regressions@leemhuis.info,
	Vinod Koul <vkoul@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH] Revert "phy: qcom: qmp-pcie: Skip PHY reset if already up"
Date: Wed, 28 Oct 2026 11:01:21 -0500
Message-ID: <20261028160121.10729-1-me@michaelburch.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <f6a49cbb-e000-4dcf-8b3b-61c3b8d934a9@leemhuis.info>
References: <20261013-qmp-pcie-skip-reset-revert-v1@michaelburch.net> <f6a49cbb-e000-4dcf-8b3b-61c3b8d934a9@leemhuis.info>
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


Yes, still needed. I retested today with unpatched upstream 7.3.0 on
the Dell XPS 13 9345 (X1E80100). It still reports "Device found, but not
active" for 1bf8000.pcie, enumerates only root port 0006:00:00.0, and
drops to dracut with no NVMe endpoint or /dev/nvme* devices. My patched
7.3.0 kernel with the revert boots successfully.


Thanks,
Michael

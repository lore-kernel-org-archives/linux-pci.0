Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102027;
	b=yrv9Mbh9rOGZCQN/It2lqUOvkDicavqWsSOf8GCOzgzmsrKQTZnSPUhkqv/7FRRNpJYT
	 c70yQAPHtKB5z6SRw18xmOuLj33/o7OLDI2dzEatIfuDUZhfK0Ul3QjWxdEwAhzm6TcGT
	 axih7JX3SddofCj08X8E4QnIZLvjW2QOxJN4CYBYYv/uK0/yH2Vp6H7DiZIGtnzv8Q0F/
	 uohS70XW8EkZ14JT05MGW7zuZzlp8WYyXPPwjNwCGh72J7G5zawT73MD6IRE6L/Vy/j6W
	 maPiefqt1C3EgfIaflSW9A2HQ/PQI+5eA5L29UWg6QTGHqZ9ma8tppgb6mur9EdF2iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102027;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=dJfiG1Iomn/Als90jreTRRE3FGx9BaAVSsyWgPeYmUk=;
	b=s5N5TMQJymsMHEgSmntzAg18qEm+z60gJGKHm25XA0PSXELJP92Kb+6gxnNwnHuGtOc1
	 V1yS5Rn8lpEz1CthBkWB/IqKtB3htE3kp9q3hdPYcMZvy8uPCc1k9dJKsvk8n71vm8YuA
	 UIvAlYKnthN/0S4yjhjGIC9/BwCUMR11OsxmpmLv3IilEJhm7C81blx2+SHUE7/Fk0qhu
	 7dv5duEY86SOVZkSGPAYVke0oQTC0fwpSAYhHWWfmoE+kixQcUfirnhDmRBnaXbiKwt8S
	 6pNqeWN5U4XV/cJN57xVnJpVbnkmoH0BFv43wI4Syd0xhy7fFL0umBg12lzGG9mH8ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Owm4O8Cg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9C5606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 11:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Owm4O8Cg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0280D1F01825;
	Tue, 27 Oct 2026 11:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793102026;
	bh=dJfiG1Iomn/Als90jreTRRE3FGx9BaAVSsyWgPeYmUk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Owm4O8Cgxa5ntbnWs3OC+0Uad9JnU5pJ9bAWdGy5qekbPVqRtQldiO5DFNx7gsYGl
	 zjzlBaYGJVodzBlxXUQtmZxxMFdW6GkJ/d5GR/Gbb4Of30AZQMirbe5jeTSJhFgv8m
	 g08NIjrA2/O+ahXxwqpryy4wCMJ9wzYw0NHKQwO22zLWGS2T+5z71MB7ELlXLQm97m
	 t/sIYgvnOXATlqSaxWQPfCUcF90hmMPGWpQluFpQPUXcUB2Z/AMefMdZawTT4lItd1
	 pAWfx5sOudYoxDtuwFgi9aiV/uhEhizAj8skGLR0xmmexTQB7C4VnfKIeh1IQbL/T3
	 WDxvpGJHhphRw==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
In-Reply-To: <1790664898-207928-1-git-send-email-shawn.lin@rock-chips.com>
References: <1790664898-207928-1-git-send-email-shawn.lin@rock-chips.com>
Subject: Re: [PATCH] PCI: dw-rockchip: Enable INTx affinity support
Message-Id: <179310201852.16692.17318855369732407934.b4-ty@b4>
Date: Tue, 27 Oct 2026 17:23:38 +0530
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=312;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=Ln4DWbgUCH/2gfmwbpXsUFycVVdbQrpXj6f1Z3vneE8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq4JDHDBZec5crnF0BSQHWIdxBK8PZtqtj2kyXM
 qM2PwAvl2iJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCauCQxwAKCRBVnxHm/pHO
 9ehIB/4tfu7NjWjmZ9W5XSIfDoj9uWXIUt3w8zQndV10pbutrnNj7mhqMlAJFNT8RhvHxp8hxK2
 sHSuycy7Tn36YRnImK/gzgUda1teP5L8J9uJuf6HO9hnrTOy4yH8S4gTvJ7E4UciWKMzOq1+aQj
 amtNorxvCa8AOog6xckB2CvG2JVpmWCVn1dv05OOFkAcMg+rb4NvZN8X76lvawtf/gncfqN1wGv
 /FooAYihOQ99CeUvIg4Ibz10/0xV/JBM1zk0Jdnei3/Vk5QsawLW6/tR2dd6D6G7iIEcy8rnAK5
 uSI+nvm7urGzS1fe3KYgc973nv4swWwjPfG/qUfwaxhQy+GP
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Tue, 29 Sep 2026 14:54:58 +0800, Shawn Lin wrote:
> PCI: dw-rockchip: Enable INTx affinity support

Applied, thanks!

[1/1] PCI: dw-rockchip: Enable INTx affinity support
      commit: 77daa4d0f47dc34a44cf9b8141478c4c2a4eab7b

Best regards,
-- 
மணிவண்ணன் சதாசிவம்



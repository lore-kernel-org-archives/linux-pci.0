Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A40841A4FD;
	Wed, 14 Oct 2026 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791965509; cv=none; b=l9xRavuTSyYuIEutPtLDZ3JN3aFWwqzN8udr42PAH8Rwf+1mwuRHrkYqykBD1qtbTfrGQz3Jd1Ff+zn9nAcn0foNlKxdjHlo/XC/FsvUzkhVRebhnmcoJ1oPAVolmKZifMNvGFnmb1nWIP4p0nQh0rqyUPwdQ7KzBsGY9xJXbCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791965509; c=relaxed/simple;
	bh=lcEYR/JTtkLEZjqcVWOMktUl3bL+j81cML0UjLIggb0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=kblnwf8n6mhIWSkklSG4djpP6wG7JrMEQypU1qhfTxkP3I54FTgEzb6NZ34H4zmYsX6rjGQY/8hYlZyKPvwW5Esoca1a4b2MZU+0bI60PBjUJLRJsXmBIGB7MIvci9/XGuYw/UIO/XjhIlGq430PMt927RGG/YnBLsONVjUGQaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93F91F000FF;
	Wed, 14 Oct 2026 08:11:41 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] PCI: qcom: Ignore -ENODEV after Root Port reset
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
In-Reply-To: <aqq7j9L76coy65lC@ryzen>
References: <20260916-topic-pcie_portrec_enodev-v1-1-5dc7bde39552@oss.qualcomm.com>
 <aqq7j9L76coy65lC@ryzen>
Date: Wed, 14 Oct 2026 13:41:33 +0530
Message-Id: <179196549341.38040.17376531957795312265.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2661;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=lcEYR/JTtkLEZjqcVWOMktUl3bL+j81cML0UjLIggb0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqzzk4Pql9ndteNGrqypwM6422tguj6eZNCecOO
 gqCyZzo5q2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas85OAAKCRBVnxHm/pHO
 9YakB/4woOrjwfBKI1iOqc+aUn1RiHtUMvCblm1fNf+4Cch6FEwSKVv3l83me1ZG10jqUxx98bx
 XsgOT+Wk6iDONfitdGy7aeYbrseljgv8iwGU6rZZLk/+IVXo5hZYR9njDexnnTczTqUFWsFP5Yk
 Wj3PsUQVhSoJnDt5Xa/t4zqQS2eikte8nTl0wn6enphQEXtMHTQu595XtBR01XtW59p6uAtD8uq
 /HHEbQVM2/Xinahsk6DgE+/xCvSGw38d57V3GcHrWJjzi9pcUpYlpzUcQa40huEBarSnEN9kjyI
 kZuA1TXyLF2CO4p9AxbZz7ObSmbYNV2ZN94osDGNyJKOXRed
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-09-16 17:53 +0200, Niklas Cassel wrote:
> Hello Konrad,
> 
> On Wed, Sep 16, 2026 at 02:37:49PM +0200, Konrad Dybcio wrote:
> > Root Port recovery may race with a device hot-unplug. In that case,
> > dw_pcie_wait_for_link() returns -ENODEV because no device is detected
> > after the controller has been successfully reset.
> > 
> > This is a valid outcome and should not cause Root Port recovery to
> > fail. Ignore -ENODEV while continuing to propagate other link-training
> > errors.
> > 
> > Assisted-by: LLM
> > Fixes: 4d88cb82a6d9 ("PCI: qcom: Implement .reset_root_port() and use for link down")
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index ee63a6ec99de4d07c16b8d6cb68df0d92f822cd8..3d3be9bf798b7c247d69969d6570385b8648123f 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -1880,6 +1880,9 @@ static int qcom_pcie_reset_root_port(struct pci_host_bridge *bridge,
> >  	qcom_pcie_start_link(pci);
> >  
> >  	ret = dw_pcie_wait_for_link(pci);
> > +	/* This linkdown might have been a hot-unplug */
> > +	if (ret == -ENODEV)
> > +		ret = 0;
> >  	if (ret)
> >  		return ret;
> 
> 
> I did not know that pcie-qcom supported hotplug.
> 
> Last when I was discussing this with Mani, I'm quite sure that he said that
> it doesn't, see:
> https://lore.kernel.org/all/20251222064207.3246632-8-cassel@kernel.org/
> 

That was my understanding at that time as the hotplug command completions were
getting timedout even though the RP claimed that it supported hotplug:

pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2020 msec ago)

Then I asked around internally within Qcom and they claimed that nobody tested
hotplug on Qcom SoCs as the usecases were mostly mobile at that time (soldered
EPs), so hotplug may not work and we should not claim it to be supported.

So I went ahead and disabled hotplug capability of the RPs with:
a54db86ddc153 ("PCI: qcom: Do not advertise hotplug capability for IPs v2.7.0
and v1.9.0")

Then after some time, we started getting form factors with hotpluggable slots
and when we tested hotplug with the above commit reverted, it actually worked,
despite the command completion timeouts. So we finally added hotplug capability
back with:

33a76fc3c3e6 ("PCI: qcom: Advertise Hotplug Slot Capability with no Command
Completion support")

- Mani


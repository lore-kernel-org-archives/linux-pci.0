Received: from outbound.qs.icloud.com (qs-2007c-snip4-3.eps.apple.com [57.103.84.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B73D3CCFB7
	for <linux-pci@vger.kernel.org>; Fri,  3 Apr 2026 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.84.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775234751; cv=none; b=KZMjuF4HW5n5jgSb+SOW6f4/JNtUPDZ0pvUhRECQYLFTY+D5ENjBPLygJS5q4+BUevz14pRQzun8A3jgzLFCs/XV7uL4xCfRLTVUDKHTVo3zQyLU53Uh6xV22TkPKFNv4Pth5TgB8KIPe94vaTmj5lUvzDG7UpszHeJDZK7GrgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775234751; c=relaxed/simple;
	bh=i+cu2XfJ0/VipmrjHQXx+UuvAVk0AeKwy6wL7Cjrk/8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=m9zzoxwN2G+gF7RvDwQv9Hf8mSyEAt3XGV230CquhxOCjhro491nnUCg3wfwYC/uKUPtjfEiN+jE1xw8BpJxqma1L1rIRuSJo5R8KpbO6GGxdv8IqsDTymqBoVmxoeHGfuGFZRnuagoKpiYUYMiJzG4Vs0u69xLcKL/euacD1MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=EahlqkMm; arc=none smtp.client-ip=57.103.84.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="EahlqkMm"
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-100-percent-8 (Postfix) with ESMTPS id B53F51800367;
	Fri, 03 Apr 2026 16:45:43 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775234747; x=1777826747; bh=l6n1Sz4zU7ZCL1MFiNRAjvokkEmLKWXQQsKV7JYXJfA=; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme; b=EahlqkMm93mFqyQKDcjDd5GoX2oIPIGRG+bupjvhSlEm3nzXSdObBR2HI6U+d+gvyi4/v/El/ULh+4FCEJI/AnxMGoo3UXl+o8UiSbA/aLCP0Maf+a9oRAs2iJAf9cj66Y8NMDthbB7mvn70bnXmeWJ/6S54GTRYu64Uo9scp9fsAh++PB+b6W5vGTHL4tabnFKMWoqwW736Z4Wdoe0LXFmByLGI7nryw8bRGExHHbbEBH0yF6gRXWOTamj7J3vOe5SIWa5EsKbfIGoRmbgq/9jAXKhM8WorsucaD8MqGgSwQ3xnydj7vHlSpMHEG00kacUIPepO/CpvywryZ/v64A==
Received: from smtpclient.apple (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-100-percent-8 (Postfix) with ESMTPSA id DB877180014B;
	Fri, 03 Apr 2026 16:45:41 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Regression Re: [PATCH v3 1/4] PCI: Enable ACS only after configuring
 IOMMU for OF platforms
From: Jon Kohler <jonmkohler@icloud.com>
In-Reply-To: <20260102-pci_acs-v3-1-72280b94d288@oss.qualcomm.com>
Date: Fri, 3 Apr 2026 12:45:29 -0400
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
 Xingang Wang <wangxingang5@huawei.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 Manivannan Sadhasivam <mani@kernel.org>,
 sashal@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B4914F2A-B2AC-4C3E-B4D2-F9C32527FDC3@icloud.com>
References: <20260102-pci_acs-v3-0-72280b94d288@oss.qualcomm.com>
 <20260102-pci_acs-v3-1-72280b94d288@oss.qualcomm.com>
To: manivannan.sadhasivam@oss.qualcomm.com
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE0OSBTYWx0ZWRfXxbGiZEEOhN4a
 RTnoy71nU1FeHf2UYjTuXcsLezsYgdGSAFvX0YfcApTVrMZsSp0XK3LHqtKDe48POyZyIj23HYP
 8tSpVubb8WuGOXaRN1iXRV4oCtkRsgCx5dcwFO0FDZ35w75sMQc9LneAq6VsF5kS5M+iggWt0FE
 LrZ47O+st1h3u0boMPEtMehDuXWPMltnTZ4o5atU+cMk5/tpX2H22biQsJsgbhOz/TdsqQaNtJa
 KKZBUCep9DAQVV+HGE4cx/cUc66D0q5OZ+QTk9rcL88c8AO2zxxoEGbyarorfZzpoaZK4RnUeit
 v7OiJRV3fvZy2UUb0DLs/u8PEmvlPi8C4tRGCCieGxHil1dFZFZPev7kGvr91c=
X-Authority-Info-Out: v=2.4 cv=CNgnnBrD c=1 sm=1 tr=0 ts=69cfeeb9
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=x7bEGLp0ZPQA:10 a=azN_SmmUUI8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=hD80L64hAAAA:8 a=KKAkSRfTAAAA:8
 a=XAu3VhzttILKBu_4kTwA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ZIRTZ7pcuX0hD3sj4RsbJL4LCzeXnyUh
X-Proofpoint-ORIG-GUID: ZIRTZ7pcuX0hD3sj4RsbJL4LCzeXnyUh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604030149



> On Jan 2, 2026, at 10:34=E2=80=AFAM, Manivannan Sadhasivam via B4 =
Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
>=20
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>=20
> For enabling ACS without the cmdline params, the platform drivers are
> expected to call pci_request_acs() API which sets a static flag,
> 'pci_acs_enable' in drivers/pci/pci.c. And this flag is used to enable =
ACS
> in pci_enable_acs() helper, which gets called during pci_acs_init(), =
as per
> this call stack:
>=20
> -> pci_device_add()
> -> pci_init_capabilities()
> -> pci_acs_init()
> /* check for pci_acs_enable */
> -> pci_enable_acs()
>=20
> For the OF platforms, pci_request_acs() is called during
> of_iommu_configure() during device_add(), as per this call stack:
>=20
> -> device_add()
> -> iommu_bus_notifier()
> -> iommu_probe_device()
> -> pci_dma_configure()
> -> of_dma_configure()
> -> of_iommu_configure()
> /* set pci_acs_enable */
> -> pci_request_acs()
>=20
> As seen from both call stacks, pci_enable_acs() is called way before =
the
> invocation of pci_request_acs() for the OF platforms. This means,
> pci_enable_acs() will not enable ACS for the first device that gets
> enumerated, which is usally the Root Port device. But since the static
> flag, 'pci_acs_enable' is set *afterwards*, ACS will be enabled for =
the
> ACS capable devices enumerated later.
>=20
> To fix this issue, do not call pci_enable_acs() from pci_acs_init(), =
but
> only from pci_dma_configure() after calling of_dma_configure(). This =
makes
> sure that pci_enable_acs() only gets called after the IOMMU framework =
has
> called pci_request_acs(). The ACS enablement flow now looks like:
>=20
> -> pci_device_add()
> -> pci_init_capabilities()
> /* Just store the ACS cap */
> -> pci_acs_init()
> -> device_add()
> ...
> -> pci_dma_configure()
> -> of_dma_configure()
> -> pci_request_acs()
> -> pci_enable_acs()
>=20
> For the ACPI platforms, pci_request_acs() is called during ACPI
> initialization time itself, independent of the IOMMU framework.
>=20
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Manivannan Sadhasivam =
<manivannan.sadhasivam@oss.qualcomm.com>
> ---
> drivers/pci/pci-driver.c | 8 ++++++++
> drivers/pci/pci.c        | 8 --------
> drivers/pci/pci.h        | 1 +
> 3 files changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 7c2d9d596258..301a9418e38e 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1650,6 +1650,14 @@ static int pci_dma_configure(struct device =
*dev)
> ret =3D acpi_dma_configure(dev, acpi_get_dma_attr(adev));
> }
>=20
> + /*
> + * Attempt to enable ACS regardless of capability because some Root
> + * Ports (e.g. those quirked with *_intel_pch_acs_*) do not have
> + * the standard ACS capability but still support ACS via those
> + * quirks.
> + */
> + pci_enable_acs(to_pci_dev(dev));
> +
> pci_put_host_bridge_device(bridge);
>=20
> /* @drv may not be valid when we're called from the IOMMU layer */
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 13dbb405dc31..2c3d0a2d6973 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3648,14 +3648,6 @@ bool pci_acs_path_enabled(struct pci_dev =
*start,
> void pci_acs_init(struct pci_dev *dev)
> {
> dev->acs_cap =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
> -
> - /*
> - * Attempt to enable ACS regardless of capability because some Root
> - * Ports (e.g. those quirked with *_intel_pch_acs_*) do not have
> - * the standard ACS capability but still support ACS via those
> - * quirks.
> - */
> - pci_enable_acs(dev);
> }
>=20
> /**
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 0e67014aa001..4592ede0ebcc 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -939,6 +939,7 @@ static inline resource_size_t =
pci_resource_alignment(struct pci_dev *dev,
> }
>=20
> void pci_acs_init(struct pci_dev *dev);
> +void pci_enable_acs(struct pci_dev *dev);
> #ifdef CONFIG_PCI_QUIRKS
> int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
> int pci_dev_specific_enable_acs(struct pci_dev *dev);
>=20
> --=20
> 2.48.1
>=20

Howdy folks,
Writing to report a regression from this patch. While attempting to
rebase our 6.12.y-based internal tree past 6.12.75, we encountered a
behavior change in our internal systems, wherein we have a platform
that uses vfio-pci passthrough for a series of PCIe devices (SAS HBAs,
NVMe SSDs, NIC passthrough, etc) to a given service VM.

On some, but not all, of these systems, we noticed that the iommu
group topology completely changes with this commit. Before this commit,
a given system may have ~90-ish iommu groups. After this commit, we see
~60-ish iommu groups.

The net result is that some of the devices marked for passthrough get
clubbed together with devices that are not marked for passthrough. As
such, libvirt refuses to start the VM, like so:=20

[root@demo-system-here ~]# virsh start demo-service-vm
error: Failed to start domain 'demo-service-vm'
2026-04-02T03:52:17.098998Z qemu-kvm: -device =
{"driver":"vfio-pci","host":"0000:41:00.0","id":"ua-cb173399-0c46-5b7a-b3e=
6-fe2fb5f9509c","bus":"pci.0","addr":"0x7","rombar":0}: vfio =
0000:41:00.0: group 8 is not viable
Please ensure all devices within the iommu_group are bound to their vfio =
bus driver.

[root@demo-system-here ~]# lspci |grep 41:00
...
41:00.0 Serial Attached SCSI controller: Broadcom / LSI Fusion-MPT =
12GSAS/PCIe Secure SAS38xx
Subsystem: Super Micro Computer Inc AOC-S3816L-L16iT (NI22) Storage =
Adapter
Kernel driver in use: vfio-pci
Kernel modules: mpt3sas=20

[root@demo-system-here ~]# ls -l /sys/kernel/iommu_groups/8/devices
total 0
lrwxrwxrwx. 1 root root 0 Apr 2 07:33 0000:40:01.0 -> =
../../../../devices/pci0000:40/0000:40:01.0
lrwxrwxrwx. 1 root root 0 Apr 2 07:33 0000:40:01.1 -> =
../../../../devices/pci0000:40/0000:40:01.1
lrwxrwxrwx. 1 root root 0 Apr 2 07:33 0000:40:01.2 -> =
../../../../devices/pci0000:40/0000:40:01.2
lrwxrwxrwx. 1 root root 0 Apr 2 07:33 0000:41:00.0 -> =
../../../../devices/pci0000:40/0000:40:01.1/0000:41:00.0
lrwxrwxrwx. 1 root root 0 Apr 2 07:33 0000:42:00.0 -> =
../../../../devices/pci0000:40/0000:40:01.2/0000:42:00.0

The tricky bit here is 41 is the SAS controller we're trying to pass
through, and 42 is the local NVMe m.2 boot disk that the server itself
is booting off of.

Before this patch, they are put in separate groups, and there is not
a problem.

I=E2=80=99ve only tried this on our 6.12.y tree, but not yet our 6.18 =
and 6.6
trees, so I=E2=80=99m not sure if this problem exists there yet, but =
this
commit is in those trees in general in 6.18.16 and 6.6.128 respectively

Happy to provide any other details you might like, as this is 100%
reproducible on a variety of systems here.

Thanks,
Jon


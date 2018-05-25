Return-Path: <SRS0=ZF2b=IM=intel.com=jacob.e.keller@kernel.org>
Return-Path: <SRS0=ZF2b=IM=intel.com=jacob.e.keller@kernel.org>
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Jakub Kicinski
	<jakub.kicinski@netronome.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Sathya Perla <sathya.perla@broadcom.com>, "Felix
 Manlunas" <felix.manlunas@caviumnetworks.com>, "alexander.duyck@gmail.com"
	<alexander.duyck@gmail.com>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, Donald Dutile <ddutile@redhat.com>,
	"oss-drivers@netronome.com" <oss-drivers@netronome.com>, Christoph Hellwig
	<hch@infradead.org>, Derek Chickles <derek.chickles@caviumnetworks.com>,
	Satanand Burla <satananda.burla@caviumnetworks.com>, Raghu Vatsavayi
	<raghu.vatsavayi@caviumnetworks.com>, Ajit Khaparde
	<ajit.khaparde@broadcom.com>, Sriharsha Basavapatna
	<sriharsha.basavapatna@broadcom.com>, Somnath Kotur
	<somnath.kotur@broadcom.com>, "Kirsher, Jeffrey T"
	<jeffrey.t.kirsher@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
Subject: RE: [PATCH] PCI: allow drivers to limit the number of VFs to 0
Date: Fri, 25 May 2018 17:46:47 +0000
Message-ID: <02874ECE860811409154E81DA85FBB5882E539EA@ORSMSX115.amr.corp.intel.com>
References: <20180402224652.4058-1-jakub.kicinski@netronome.com>
 <20180524235748.GD15320@bhelgaas-glaptop.roam.corp.google.com>
 <20180524182015.1af7b4c9@cakuba>
 <20180525140223.GA45098@bhelgaas-glaptop.roam.corp.google.com>
 <20180525170122.GA63280@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180525170122.GA63280@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Friday, May 25, 2018 10:01 AM
> To: Jakub Kicinski <jakub.kicinski@netronome.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org;
> netdev@vger.kernel.org; Sathya Perla <sathya.perla@broadcom.com>; Felix
> Manlunas <felix.manlunas@caviumnetworks.com>;
> alexander.duyck@gmail.com; john.fastabend@gmail.com; Keller, Jacob E
> <jacob.e.keller@intel.com>; Donald Dutile <ddutile@redhat.com>; oss-
> drivers@netronome.com; Christoph Hellwig <hch@infradead.org>; Derek
> Chickles <derek.chickles@caviumnetworks.com>; Satanand Burla
> <satananda.burla@caviumnetworks.com>; Raghu Vatsavayi
> <raghu.vatsavayi@caviumnetworks.com>; Ajit Khaparde
> <ajit.khaparde@broadcom.com>; Sriharsha Basavapatna
> <sriharsha.basavapatna@broadcom.com>; Somnath Kotur
> <somnath.kotur@broadcom.com>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; intel-wired-lan@lists.osuosl.org
> Subject: Re: [PATCH] PCI: allow drivers to limit the number of VFs to 0
>=20
> [+cc liquidio, benet, fm10k maintainers:
>=20
>   The patch below will affect you if your driver calls
>     pci_sriov_set_totalvfs(dev, 0);
>=20
>   Previously that caused a subsequent pci_sriov_get_totalvfs() to return
>   the totalVFs value from the SR-IOV capability.  After this patch, it wi=
ll
>   return 0, which has implications for VF enablement via the sysfs
>   "sriov_numvfs" file.]
>=20

Thanks. I don't foresee any issues with fm10k regarding this..

Thanks,
Jake

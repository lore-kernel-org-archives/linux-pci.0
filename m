Return-Path: <SRS0=+N2R=2M=amd.com=brijesh.singh@kernel.org>
Return-Path: <SRS0=+N2R=2M=amd.com=brijesh.singh@kernel.org>
Subject: Re: [RFC PATCH v2 00/32] x86: Secure Encrypted Virtualization (AMD)
To: Bjorn Helgaas <helgaas@kernel.org>
References: <148846752022.2349.13667498174822419498.stgit@brijesh-build-machine>
 <20170303203323.GA5305@bhelgaas-glaptop.roam.corp.google.com>
CC: <brijesh.singh@amd.com>, <simon.guinot@sequanux.org>,
	<linux-efi@vger.kernel.org>, <kvm@vger.kernel.org>, <rkrcmar@redhat.com>,
	<matt@codeblueprint.co.uk>, <linux-pci@vger.kernel.org>,
	<linus.walleij@linaro.org>, <gary.hook@amd.com>, <linux-mm@kvack.org>,
	<paul.gortmaker@windriver.com>, <hpa@zytor.com>, <cl@linux.com>,
	<dan.j.williams@intel.com>, <aarcange@redhat.com>, <sfr@canb.auug.org.au>,
	<andriy.shevchenko@linux.intel.com>, <herbert@gondor.apana.org.au>,
	<bhe@redhat.com>, <xemul@parallels.com>, <joro@8bytes.org>, <x86@kernel.org>,
	<peterz@infradead.org>, <piotr.luc@intel.com>, <mingo@redhat.com>,
	<msalter@redhat.com>, <ross.zwisler@linux.intel.com>, <bp@suse.de>,
	<dyoung@redhat.com>, <thomas.lendacky@amd.com>, <jroedel@suse.de>,
	<keescook@chromium.org>, <arnd@arndb.de>, <toshi.kani@hpe.com>,
	<mathieu.desnoyers@efficios.com>, <luto@kernel.org>,
	<devel@linuxdriverproject.org>, <bhelgaas@google.com>, <tglx@linutronix.de>,
	<mchehab@kernel.org>, <iamjoonsoo.kim@lge.com>, <labbott@fedoraproject.org>,
	<tony.luck@intel.com>, <alexandre.bounine@idt.com>, <kuleshovmail@gmail.com>,
	<linux-kernel@vger.kernel.org>, <mcgrof@kernel.org>, <mst@redhat.com>,
	<linux-crypto@vger.kernel.org>, <tj@kernel.org>, <pbonzini@redhat.com>,
	<akpm@linux-foundation.org>, <davem@davemloft.net>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <d1ded08e-1a53-4762-84af-c5979bf9ed32@amd.com>
Date: Fri, 3 Mar 2017 15:15:30 -0600
MIME-Version: 1.0
In-Reply-To: <20170303203323.GA5305@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 03/03/2017 02:33 PM, Bjorn Helgaas wrote:
> On Thu, Mar 02, 2017 at 10:12:01AM -0500, Brijesh Singh wrote:
>> This RFC series provides support for AMD's new Secure Encrypted Virtualization
>> (SEV) feature. This RFC is build upon Secure Memory Encryption (SME) RFCv4 [1].
>
> What kernel version is this series based on?
>

This patch series is based off of the master branch of tip.
   Commit a27cb9e1b2b4 ("Merge branch 'WIP.sched/core'")
   Tom's RFC v4 patches (http://marc.info/?l=linux-mm&m=148725973013686&w=2)

Accidentally, I ended up rebasing SEV RFCv2 patches from updated SME v4 
instead of original SME v4. So you may need to apply patch [1]

[1] http://marc.info/?l=linux-mm&m=148857523132253&w=2

Optionally, I have posted the full git tree here [2]

[2] https://github.com/codomania/tip/branches

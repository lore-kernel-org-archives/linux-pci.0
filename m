Return-Path: <jcm@redhat.com>
Return-Path: <jcm@redhat.com>
Subject: Re: [PATCH V8 0/9] Support for ARM64 ACPI based PCI host controller
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "will.deacon@arm.com"
 <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
        "Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "jchandra@broadcom.com" <jchandra@broadcom.com>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F767865@lhreml507-mbx>
Cc: "robert.richter@caviumnetworks.com" <robert.richter@caviumnetworks.com>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
        "ddaney@caviumnetworks.com" <ddaney@caviumnetworks.com>,
        Wangyijing <wangyijing@huawei.com>,
        "Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>,
        "msalter@redhat.com" <msalter@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
        "jcm@redhat.com" <jcm@redhat.com>,
        "andrea.gallo@linaro.org" <andrea.gallo@linaro.org>,
        "dhdang@apm.com" <dhdang@apm.com>,
        "jeremy.linton@arm.com" <jeremy.linton@arm.com>
From: Jon Masters <jcm@redhat.com>
Message-ID: <f606faa9-72f3-3219-02a8-69e948338d2e@redhat.com>
Date: Thu, 2 Jun 2016 03:31:38 -0400
MIME-Version: 1.0
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F767865@lhreml507-mbx>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 06/01/2016 03:36 AM, Gabriele Paoloni wrote:

> If you agree I think Jon can tell who's the best person to
> push the quirk RFC (as my understanding is that this mechanism
> is currently used by some platforms deployed on the market...)

Let me ping Linaro folks to see who has that (quirks) ball. We can
certainly share the older OEM matching quirks Mark Salter did for
earlier RHEL(SA) internal versions as a seed for that[0] activity.

BUT...I don't think we should block this thread on the quirks. They're
separate (but important). I see Arnd's reply as well, but nobody else
has yet chimed in to this thread (and I am about to prod all of the
vendors to reply to this thread and ACK). Can I ask whether we can't
just stage v8 as-is for -next at this point? Can Arnd's (or other)
suggestions be handled as followup patches post-merge please? Bjorn?

Jon.

[0] RHEL(SA) has had three different PCIe enabled ACPI stacks maintained
independently so far since we need PCIe to boot most of the hundreds of
v8 systems we have internal to Red Hat - which all have PCI.

-- 
Computer Architect | Sent from my Fedora powered laptop

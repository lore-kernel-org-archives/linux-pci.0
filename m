Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH] PCI: move early dump functionality from x86 arch into the
 common code
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1527654876-26716-1-git-send-email-okaya@codeaurora.org>
 <CAHp75Vc3YKAR1P_F0fwD+ueGub4gVUjP0=wv4Egf_fTSVkSUjw@mail.gmail.com>
 <53e4d6c3-ee19-fd04-4ba3-862d04558689@codeaurora.org>
 <CAHp75VdTyvQOqnSm67Uo5heP1otE98BbquM0TjSAorEzTgUwHQ@mail.gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <37da9c96-1444-29d0-f1a1-7250debc1a07@codeaurora.org>
Date: Fri, 1 Jun 2018 11:24:45 -0400
MIME-Version: 1.0
In-Reply-To: <CAHp75VdTyvQOqnSm67Uo5heP1otE98BbquM0TjSAorEzTgUwHQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 linux-pci@vger.kernel.org, Petr Tesarik <ptesarik@suse.cz>,
 Ram Pai <linuxram@us.ibm.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Christoffer Dall <cdall@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Timur Tabi <timur@codeaurora.org>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, David Rientjes <rientjes@google.com>,
 Thymo van Beers <thymovanbeers@gmail.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-arm-msm@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Juergen Gross <jgross@suse.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>,
 Borislav Petkov <bp@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 open list <linux-kernel@vger.kernel.org>,
 Philippe Ombredanne <pombredanne@nexb.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 6/1/2018 11:24 AM, Andy Shevchenko wrote:
>> This was discussed here:
>>
>> https://www.spinics.net/lists/linux-pci/msg72859.html
> I understand what is it. What I'm pointing is the variable in the
> source without any comment. In the context you have in diff previous
> one has a comment.

oh, ok. I can take care of that too.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
